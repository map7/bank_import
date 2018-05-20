import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import Turbolinks from "turbolinks";
import Rails from "rails-ujs";
import Chartkick from "chartkick";
import Chart from "chart.js";

const application = Application.start();
const context = require.context("../controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

Rails.start();
Turbolinks.start();
Chartkick.addAdapter(Chart);
