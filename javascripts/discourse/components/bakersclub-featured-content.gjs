import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { defaultHomepage } from "discourse/lib/utilities";
import DButton from "discourse/ui-kit/d-button";
import icon from "discourse/ui-kit/helpers/d-icon";

export default class BakersClubFeaturedContent extends Component {
  @service router;
  @service keyValueStore;

  @tracked
  isCollapsed =
    this.keyValueStore.getItem("bakersclubFeaturedContentCollapsed") === "true";

  get shouldShow() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  get featuredItems() {
    return settings.featured_items || [];
  }

  @action
  toggleContent() {
    this.isCollapsed = !this.isCollapsed;

    this.keyValueStore.setItem(
      "bakersclubFeaturedContentCollapsed",
      this.isCollapsed
    );
  }

  <template>
    {{#if this.shouldShow}}
      {{#if this.featuredItems.length}}
        <div
          class="bakersclub-featured-content
            {{unless this.isCollapsed 'is-open'}}"
        >

          <DButton
            class="bakersclub-featured-content__toggle"
            @action={{this.toggleContent}}
            @translatedLabel={{settings.section_title}}
          >
            {{#if this.isCollapsed}}
              {{icon "angle-right"}}
            {{else}}
              {{icon "angle-down"}}
            {{/if}}
          </DButton>

          {{#unless this.isCollapsed}}
            <div class="bakersclub-featured-content__items">
              {{#each this.featuredItems as |item|}}
                <article class="bakersclub-featured-content__item">

                  <a
                    class="bakersclub-featured-content__image"
                    href={{item.url}}
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    <img src={{item.image}} alt="" />
                  </a>

                  <h3 class="bakersclub-featured-content__item-title">
                    <a
                      href={{item.url}}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {{item.title}}
                    </a>
                  </h3>

                </article>
              {{/each}}
            </div>
          {{/unless}}

        </div>
      {{/if}}
    {{/if}}
  </template>
}
