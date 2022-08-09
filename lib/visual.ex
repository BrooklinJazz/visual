defmodule Visual do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Visual"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""
    title = (attrs["title"] && attrs["title"] != "") || "Visual"

    {:ok, assign(ctx, title: title, source: source),
     editor: [
       attribute: "code",
       language: "elixir",
       default_source: attrs["default_source"] || ""
     ]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{title: ctx.assigns.title, source: ctx.assigns.source}, ctx}
  end

  @impl true
  def handle_event("update_source", %{"source" => source}, ctx) do
    broadcast_event(ctx, "update_source", %{"source" => source})
    {:noreply, assign(ctx, source: source)}
  end

  @impl true
  def handle_event("update_title", %{"title" => title}, ctx) do
    broadcast_event(ctx, "update_title", %{"title" => title})
    {:noreply, assign(ctx, title: title)}
  end

  @impl true
  def to_attrs(ctx) do
    %{"source" => ctx.assigns.source, "title" => ctx.assigns.title}
  end

  @impl true
  def to_source(attrs) do
    """
    #{attrs["code"]}
    #{attrs["source"]}
    """
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");

      ctx.root.innerHTML = `
        <section id="container">
          <p id="title">${payload.title}</p>
          <section id="editors">
              <label for="title">Title</label>
              <input name="title" id="title_editor"/>
              <label for="source">Source</label>
              <textarea name="source" id="source"></textarea>
          </section>
        </section>
      `;

      const textarea = ctx.root.querySelector("#source");
      const title = ctx.root.querySelector("#title");
      const editors = ctx.root.querySelector("#editors");
      const title_editor = ctx.root.querySelector("#title_editor");
      const container = ctx.root.querySelector("#container");

      editors.style.display = "none"

      textarea.value = payload.source;
      title_editor.value = payload.title;

      textarea.addEventListener("change", (event) => {
        ctx.pushEvent("update_source", { source: event.target.value });
      });

      title_editor.addEventListener("change", (event) => {
        ctx.pushEvent("update_title", { title: event.target.value });
      });

      title.addEventListener("dblclick", (event) => {
        if (editors.style.display == "none") {
          editors.style.display = "block"
        } else {
          editors.style.display = "none"
        }
      });

      ctx.handleEvent("update_source", ({ source }) => {
        textarea.value = source;
      });

      ctx.handleEvent("update_title", ({ title: title_text }) => {
        title_editor.value = title_text;
        title.innerHTML = title_text || "Visual";
      });

      ctx.handleSync(() => {
        // Synchronously invokes change listeners
        document.activeElement &&
          document.activeElement.dispatchEvent(new Event("change"));
      });
    }
    """
  end

  asset "main.css" do
    """
    #source {
      box-sizing: border-box;
      width: 100%;
      min-height: 100px;
    }

    input, label {
      display: block;
    }

    #container {
      padding: 0.3rem;
      background-color: rgb(240 245 249);
      border-radius: 0.5rem 0.5rem 0 0;
      font-weight: 500;
      color: rgb(97 117 138);
      font-family: Inter, system-ui,-apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji;
    }

    #title {
      cursor: pointer;
      text-align: center;
    }
    """
  end
end
