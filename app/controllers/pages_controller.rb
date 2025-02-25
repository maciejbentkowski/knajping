class PagesController < ApplicationController
    def main
        @reviews = Review.recent.includes(:venue)
    end
end
