class RevenueSerializer
  include JSONAPI::Serializer
  def self.revenue(rev)
    {
      "data": {
        "id": nil,
        "attributes": {
          "revenue": rev
        }
      }
    }
  end
end
