import Component from "@glimmer/component";
import { service } from "@ember/service";
import { defaultHomepage } from "discourse/lib/utilities";
import BakersClubFeaturedSection from "./bakersclub-featured-section";

export default class BakersClubFeaturedContent extends Component {
  @service currentUser;
  @service router;

  get shouldShow() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  get sections() {
    const sections = settings.featured_sections || [];
    const items = settings.featured_items || [];

    const userGroupIds = new Set(
      (this.currentUser?.groups || []).map((group) => Number(group.id))
    );

    return sections
      .filter((section) => {
        const allowedGroups = section.allowed_groups || [];

        return (
          allowedGroups.length === 0 ||
          allowedGroups.some((groupId) => userGroupIds.has(Number(groupId)))
        );
      })
      .map((section) => ({
        id: section.section_id,
        title: section.title,
        items: items.filter((item) => item.section_id === section.section_id),
      }))
      .filter((section) => section.items.length > 0);
  }

  <template>
    {{#if this.shouldShow}}
      {{#each this.sections key="id" as |section|}}
        <BakersClubFeaturedSection @section={{section}} />
      {{/each}}
    {{/if}}
  </template>
}
