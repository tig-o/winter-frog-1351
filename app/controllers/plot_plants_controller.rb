class PlotPlantsController < ApplicationController
    def destroy
        plot_plant = PlotPlant.find(params[:id])
        plot_plant.delete
        redirect_to plots_path
    end
end