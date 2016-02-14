require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::JSONAck do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ jsonack }).should.be.instance_of Command::JSONAck
      end
    end
  end
end
