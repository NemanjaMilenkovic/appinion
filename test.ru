class BankAccount

    def accountNumber
         @accountNumber
    end
 
    def accountNumber=( value )
         @accountNumber = value
    end
 
    def accountName
         @accountName
    end
 
    def accountName=( value )
         @accountName = value
    end
 
 end

 account = BankAccount.new()

account.accountName

  account.accountNumber = 1
 puts account.accountNumber


myText = <<DOC
Please Detach and return this coupon with your payment.
….
Thank you for your business.
DOC
puts myText