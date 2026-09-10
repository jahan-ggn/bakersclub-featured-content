import { apiInitializer } from "discourse/lib/api";
import BakersClubFeaturedContent from "../components/bakersclub-featured-content";

export default apiInitializer((api) => {
  api.renderInOutlet(
    "discovery-list-controls-above",
    BakersClubFeaturedContent
  );
});
