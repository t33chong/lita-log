module Lita
  module Handlers
    class Log < Handler
      # insert handler code here

      Lita.register_handler(self)
    end
  end
end
