import { Controller } from "stimulus"
import Chartkick from "chartkick"
import Chart from "chart.js"
import Rails from "rails-ujs"

export default class extends Controller {
  initialize() {
    fetch(this.data.get("url"))
      .then(response =>
            response.text())
      .then(expenses => {
        new Chartkick.PieChart("chart-1", JSON.parse(expenses))
      })

    
  }

  destroy() {
    this.railsDelete("transactions/destroy_many");
  }

  railsDelete(url) {
    return new Promise((resolve, reject) => {
      Rails.ajax({
        url,
        type: "DELETE",
        success: response => {
          resolve(response);
        },
        error: (_jqXHR, _textStatus, errorThrown) => {
          reject(errorThrown);
        }
      });
    });
  }
}
