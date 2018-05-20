import { Controller } from "stimulus"
import Rails from "rails-ujs"

export default class extends Controller {
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
