require "rails_helper"

RSpec.describe Filter do
  describe "execute" do
    before do 
      @petrol = Account.create(code: 40, name: "Petrol")
      @transport = Account.create(code: 41, name: "Transport")
      @sundries = Account.create(code: 999, name: "Sundries")
    end
    
    context "with keywords" do
      before do 
        Filter.create(keyword: "BP", account: @petrol)
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

    context "with phrase" do
      before do 
        Filter.create(keyword: "public", account: @sundries)
        Filter.create(keyword: "", phrase: "Public Transport", account: @transport)
      end
      
      context "given Public Transport" do 
        it "filters to transport" do 
          result = Filter.execute("Public Transport")
          expect(result).to eq(Account.find_by_name("Transport"))
        end
      end

      context "given Public" do 
        it "filters to sundries" do 
          result = Filter.execute("Public")
          expect(result).to eq(Account.find_by_name("Sundries"))
        end
      end
    end
  end

  
end
