class RecordsController < ApplicationController

    before_action :require_user, only: [:new]

    def new
    end

    def create
    end


    private

    def record_params
    end


end
