require "rails_helper"

RSpec.describe Filter do
  describe "execute" do
    before do 
      petrol = Account.create(code: 40, name: "Petrol")
      sundries = Account.create(code: 999, name: "Sundries")
      Filter.create(keyword: "BP", account: petrol)
    end
    
    context "given BP" do 
      it "filters to petrol" do 
        result = Filter.execute("BP")
        expect(result).to eq(Account.find_by_name("Petrol"))
      end
    end

    context "given BPAY" do 
      it "filters to sundries" do 
        result = Filter.execute("bpay")
        expect(result).to eq(Account.find_by_name("Sundries"))
      end
    end
  end
end
