require 'rails_helper'

RSpec.describe 'gardens show page', type: :feature do
    it 'displays list of plants that are in specific gardens plots' do
        sun_garden = Garden.create!(name: "Sun Garden", organic: true)
        turing_garden = Garden.create!(name: "Turing Garden", organic: true)

        plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden: sun_garden)
        plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden: sun_garden)
        plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden: sun_garden)
        plot4 = Plot.create!(number: 4, size: "Small", direction: "West", garden: turing_garden)
        plot5 = Plot.create!(number: 5, size: "Medium", direction: "North", garden: turing_garden)
        plot6 = Plot.create!(number: 6, size: "Large", direction: "East", garden: turing_garden)

        pineapple = Plant.create!(name: "Pineapple", description: "Low maintenance", days_to_harvest: 30)
        watermelon = Plant.create!(name: "Watermelon", description: "Medium maintenance", days_to_harvest: 60)
        kiwi = Plant.create!(name: "Kiwi", description: "High maintenance", days_to_harvest: 90)
        tomato = Plant.create!(name: "Tomato", description: "Low maintenance", days_to_harvest: 30)
        onion = Plant.create!(name: "Onion", description: "Medium maintenance", days_to_harvest: 60)
        squash = Plant.create!(name: "Squash", description: "High maintenance", days_to_harvest: 90)
        pepper = Plant.create!(name: "Bell Pepper", description: "High maintenance", days_to_harvest: 90)

        PlotPlant.create!(plot: plot1, plant: pineapple)
        PlotPlant.create!(plot: plot1, plant: watermelon)
        PlotPlant.create!(plot: plot1, plant: kiwi)
        PlotPlant.create!(plot: plot2, plant: tomato)
        PlotPlant.create!(plot: plot2, plant: onion)
        PlotPlant.create!(plot: plot3, plant: squash)
        PlotPlant.create!(plot: plot3, plant: pepper)
        PlotPlant.create!(plot: plot4, plant: squash)
        PlotPlant.create!(plot: plot5, plant: onion)
        PlotPlant.create!(plot: plot6, plant: kiwi)

        visit "/gardens/#{turing_garden.id}"

        within "#list-of-plants" do
            expect(page).to have_content("Squash")
            expect(page).to have_content("Onion")
            expect(page).to have_content("Kiwi")
            expect(page).to_not have_content("Bell Pepper")
            expect(page).to_not have_content("Tomato")
        end
    end

    it 'display unique list of plants that take less than 100 days to harvest' do
        sun_garden = Garden.create!(name: "Sun Garden", organic: true)
        turing_garden = Garden.create!(name: "Turing Garden", organic: true)

        plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden: sun_garden)
        plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden: sun_garden)
        plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden: sun_garden)
        plot4 = Plot.create!(number: 4, size: "Small", direction: "West", garden: turing_garden)
        plot5 = Plot.create!(number: 5, size: "Medium", direction: "North", garden: turing_garden)
        plot6 = Plot.create!(number: 6, size: "Large", direction: "East", garden: turing_garden)

        pineapple = Plant.create!(name: "Pineapple", description: "Low maintenance", days_to_harvest: 30)
        watermelon = Plant.create!(name: "Watermelon", description: "Medium maintenance", days_to_harvest: 60)
        kiwi = Plant.create!(name: "Kiwi", description: "High maintenance", days_to_harvest: 90)
        tomato = Plant.create!(name: "Tomato", description: "Low maintenance", days_to_harvest: 30)
        onion = Plant.create!(name: "Onion", description: "Medium maintenance", days_to_harvest: 101)
        squash = Plant.create!(name: "Squash", description: "High maintenance", days_to_harvest: 90)
        pepper = Plant.create!(name: "Bell Pepper", description: "High maintenance", days_to_harvest: 90)

        PlotPlant.create!(plot: plot1, plant: pineapple)
        PlotPlant.create!(plot: plot1, plant: watermelon)
        PlotPlant.create!(plot: plot1, plant: kiwi)
        PlotPlant.create!(plot: plot2, plant: tomato)
        PlotPlant.create!(plot: plot2, plant: onion)
        PlotPlant.create!(plot: plot3, plant: squash)
        PlotPlant.create!(plot: plot3, plant: pepper)
        PlotPlant.create!(plot: plot4, plant: squash)
        PlotPlant.create!(plot: plot5, plant: onion)
        PlotPlant.create!(plot: plot6, plant: kiwi)
        PlotPlant.create!(plot: plot4, plant: kiwi)

        visit "/gardens/#{turing_garden.id}"

        within "#list-of-plants" do
            expect(page).to have_content("Squash")
            expect(page).to_not have_content("Onion") #onion takes 101 days to harvest
            expect(page).to have_content("Kiwi").once #kiwi should only be seen once, even if it grows in multiple plots of turing_garden
        end
    end

end