require 'spec_helper'

describe Location do
	let(:latitude) { 38.911268 }
	let(:longitude) { -77.444243 }
	let(:air_space) { Location.new(latitude: 38.911268, longitude: -77.444243) }



	describe 'validations' do
		before { subject.valid? } 
		[ :latitude, :longitude ].each do |coordinate|
			context "when #{coordinate} is nil" do
				subject { Location.new(coordinate => nil) }
				it "shouldn't allow blank #{coordinate}" do
					expect(subject.errors_on(coordinate)).to include("can't be blank")
				end
			end

			context "when #{coordinate} isn't numeric" do
				subject { Location.new(coordinate => "a") }
				it "shouldn't allow non-numeric #{coordinate}" do
					expect(subject.errors_on(coordinate)).to include("is not a number")
				end
			end

			context "when #{coordinate} is a decimal" do
				subject { Location.new(coordinate => 40.0) }
				it "should have no errors for #{coordinate}" do
					expect(subject).to have(0).errors_on(coordinate)
				end
			end
		end
	end

	describe '#initialize' do
		# it 'sets the latitude and longitude' do
		# 	loc = Location.new(latitude: 38.911268, longitude: -77.444243)
		# 	expect(loc.latitude).to eq 38.911268
		# 	expect(loc.longitude).to eq -77.444243
		# end
		# REFACTORED TO BELOW; 'ITS' CREATES NESTED EXAMPLE GROUP
		subject { air_space }
			its (:latitude) { should == 38.911268 } 
			its (:longitude) { should == -77.444243 } 
	end

	describe '#near?' do
		context 'when within specified radius' do
			subject { air_space }
				it { should be_near(latitude, longitude, 1) }
		end

		context 'when outside the specified radius' do
			subject { air_space }
				it { should_not be_near(latitude * 10, longitude * 10, 1) }
		end

		context 'when a negative radius is used' do
			it 'raises an error' do
				expect { air_space.near?(latitude, longitude, -1) }.to raise_error ArgumentError
			end
		end
	end

end