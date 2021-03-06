import UIKit

class PlaceBidNetworkModel: NSObject {

    var bidder:Bidder?
    var fulfillmentNav:FulfillmentNavigationController!
    var bidderPosition:BidderPosition?

    func bidSignal(auctionID: String, bidDetails: BidDetails) -> RACSignal {

        let saleArtwork = bidDetails.saleArtwork
        let cents = String(bidDetails.bidAmountCents! as Int)

        var signal = RACSignal.empty().then {

            self.bidder == nil ? self.checkForBidderOnAuction(auctionID) : RACSignal.empty()

        } .then {
            self.bidder == nil ? self.createBidderForAuction(auctionID) : RACSignal.empty()

        } .then {
            self.bidOnSaleArtwork(saleArtwork!, bidAmountCents: cents)

        }.catchTo(RACSignal.empty()).doError { [weak self] (error) -> Void in
            println("\(error)")
            return
        }

        return signal
    }

    func provider() -> ReactiveMoyaProvider<ArtsyAPI>  {
        if let provider = fulfillmentNav.loggedInProvider {
            return provider
        }
        return Provider.sharedProvider
    }

    func checkForBidderOnAuction(auctionID: String) -> RACSignal {
        let endpoint: ArtsyAPI = ArtsyAPI.MyBiddersForAuction(auctionID: auctionID)
        let request = provider().request(endpoint, method: .GET, parameters:endpoint.defaultParameters).filterSuccessfulStatusCodes().mapJSON().mapToObjectArray(Bidder.self)

        return request.doNext { [weak self] (bidders) -> Void in
            let bidders = bidders as [Bidder]
            self?.bidder = bidders.first

        }.doError { (error) in
            log.error("Checking for Bidder failed.")
            log.error("Error: \(error.localizedDescription). \n \(error.artsyServerError())")
        }
    }

    func createBidderForAuction(auctionID: String) -> RACSignal {
        let endpoint: ArtsyAPI = ArtsyAPI.RegisterToBid(auctionID: auctionID)
        let request = provider().request(endpoint, method: .POST, parameters:endpoint.defaultParameters).filterSuccessfulStatusCodes().mapJSON().mapToObject(Bidder.self)

        return request.doNext { [weak self] (bidder) -> Void in
            self?.bidder = bidder as Bidder!
            return

        }.doError { (error) in
            log.error("Registering for Auction failed.")
            log.error("Error: \(error.localizedDescription). \n \(error.artsyServerError())")
        }
    }

    func bidOnSaleArtwork(saleArtwork: SaleArtwork, bidAmountCents: String) -> RACSignal {
        let bidEndpoint: ArtsyAPI = ArtsyAPI.PlaceABid(auctionID: saleArtwork.auctionID!, artworkID: saleArtwork.artwork.id, maxBidCents: bidAmountCents)

        let request = provider().request(bidEndpoint, method: .POST, parameters:bidEndpoint.defaultParameters).filterSuccessfulStatusCodes().mapJSON().mapToObject(BidderPosition.self)

        return request.doNext { [weak self] (position) -> Void in
            self?.bidderPosition = position as? BidderPosition
            return

        }.doError { (error) in
            log.error("Bidding on Sale Artwork failed.")
            log.error("Error: \(error.localizedDescription). \n \(error.artsyServerError())")
        }
    }

}
