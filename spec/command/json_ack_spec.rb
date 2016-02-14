require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Json_ack do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ json_ack }).should.be.instance_of Command::Json_ack
      end
    end
  end
end

