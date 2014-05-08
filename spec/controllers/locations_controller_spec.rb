require 'spec_helper'

describe LocationsController do
	describe '#new' do
		context 'when invalid longitude' do
			subject { post :create, { location: { latitude: 25.0 }}}
			its(:status) { should == 200 }
			it "should render the 'new' view" do
				subject
				response.should render_template("new")
			end
		end
	end

	describe '#create' do
		subject { post :create, { location: { latitude: 25.0, longitude: -40.0 }}}
		its(:status) { should == 302 }

		it "saves the location" do
			subject
			expect(Location.all.count).to eq 1
		end

		it "should redirect to show the created location" do
			subject.should redirect_to location_path(Location.first.id)
		end
	end

end
