import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/ui-kit/d-button";
import icon from "discourse/ui-kit/helpers/d-icon";

export default class BakersClubFeaturedSection extends Component {
  @service keyValueStore;

  @tracked isCollapsed = this.keyValueStore.getItem(this.storageKey) === "true";

  get contentId() {
    return `bakersclub-featured-content-${encodeURIComponent(this.args.section.id)}`;
  }

  get storageKey() {
    return `bakersclubFeaturedContentCollapsed:${this.args.section.id}`;
  }

  @action
  toggleContent() {
    this.isCollapsed = !this.isCollapsed;

    this.keyValueStore.setItem(this.storageKey, this.isCollapsed);
  }

  <template>
    <div
      class="bakersclub-featured-content {{unless this.isCollapsed 'is-open'}}"
    >
      <DButton
        aria-controls={{this.contentId}}
        aria-expanded={{unless this.isCollapsed "true" "false"}}
        class="bakersclub-featured-content__toggle"
        @action={{this.toggleContent}}
        @translatedLabel={{@section.title}}
      >
        {{#if this.isCollapsed}}
          {{icon "angle-right"}}
        {{else}}
          {{icon "angle-down"}}
        {{/if}}
      </DButton>

      <div
        class="bakersclub-featured-content__items"
        hidden={{this.isCollapsed}}
        id={{this.contentId}}
      >
        {{#unless this.isCollapsed}}
          {{#each @section.items as |item|}}
            <article class="bakersclub-featured-content__item">
              <a
                class="bakersclub-featured-content__image"
                href={{item.url}}
                rel="noopener noreferrer"
                target="_blank"
              >
                <img alt={{item.title}} src={{item.image}} />

                {{#if item.label}}
                  <span class="bakersclub-featured-content__label">
                    {{item.label}}
                  </span>
                {{/if}}
              </a>

              <h3 class="bakersclub-featured-content__item-title">
                <a href={{item.url}} rel="noopener noreferrer" target="_blank">
                  {{item.title}}
                </a>
              </h3>
            </article>
          {{/each}}
        {{/unless}}
      </div>
    </div>
  </template>
}
