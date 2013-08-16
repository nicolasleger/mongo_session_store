require 'mongoid'
require 'mongo_session_store/mongo_store_base'

module ActionDispatch
  module Session
    class MongoidStore < MongoStoreBase

      class Session
        include Mongoid::Document
        include Mongoid::Timestamps

        store_in :collection => MongoSessionStore.collection_name

        field :_id, :type => String

        field :data, :type => Moped::BSON::Binary, :default => Moped::BSON::Binary.new(:generic, Marshal.dump({}))

        # attr_accessible :_id, :data  # ActiveRecord dependent
      end

      private
      def pack(data)
        Moped::BSON::Binary.new(:generic, Marshal.dump(data))
      end
    end
  end
end

MongoidStore = ActionDispatch::Session::MongoidStore
