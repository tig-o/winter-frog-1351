require 'rails_helper'

RSpec.describe 'plots index page', type: :feature do
    it 'displays list of all plot numbers and plant of specific plots' do
        sun_garden = Garden.create!(name: "Sun Garden", organic: true)

        plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden: sun_garden)
        plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden: sun_garden)
        plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden: sun_garden)

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

        visit "/plots"

        within "#plot#{plot1.id}" do
            expect(page).to have_content("Plot Number: #1")
            expect(page).to have_content("Pineapple")
            expect(page).to have_content("Watermelon")
            expect(page).to have_content("Kiwi")
            expect(page).to_not have_content("Plot Number: #2")
            expect(page).to_not have_content("Bell Pepper")
            expect(page).to_not have_content("Tomato")
        end

        within "#plot#{plot2.id}" do
            expect(page).to have_content("Plot Number: #2")
            expect(page).to have_content("Tomato")
            expect(page).to have_content("Onion")
            expect(page).to_not have_content("Plot Number: #1")
            expect(page).to_not have_content("Bell Pepper")
            expect(page).to_not have_content("Watermelon")
        end

        within "#plot#{plot3.id}" do
            expect(page).to have_content("Plot Number: #3")
            expect(page).to have_content("Squash")
            expect(page).to have_content("Bell Pepper")
            expect(page).to_not have_content("Plot Number: #1")
            expect(page).to_not have_content("Pineapple")
            expect(page).to_not have_content("Tomato")
        end
    end

    it 'displays a link to remove plant from a plot' do
        sun_garden = Garden.create!(name: "Sun Garden", organic: true)

        plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden: sun_garden)
        plot2 = Plot.create!(number: 2, size: "Medium", direction: "East", garden: sun_garden)
        plot3 = Plot.create!(number: 3, size: "Large", direction: "South", garden: sun_garden)

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

        visit "/plots"

        within "#plot#{plot1.id}" do
            expect(page).to have_content("Pineapple")
            expect(page).to have_content("Watermelon")
            expect(page).to have_content("Kiwi")
            expect(page).to have_link("Remove Plant")

            within "#plant#{pineapple.id}" do
                click_on "Remove Plant"
            end

            expect(page).to_not have_content("Pineapple")
            expect(page).to have_content("Watermelon")
            expect(page).to have_content("Kiwi")
            expect(pineapple).to be_a(Plant)
        end

        expect(current_path).to eq("/plots")
    end
    
end