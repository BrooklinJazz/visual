# Visual

**A visual feedback Kino Smart Cell for Livebook**

## Installation

Add the dependency in your Livebook setup section. This project relies on [Kino](https://github.com/livebook-dev/kino).

```elixir
Mix.install([{:kino, "~> 0.6.2"}, {:visual, github: "BrooklinJazz/visual"}])
```

## Usage

Visual cells display visual feedback for an Elixir cell.

![image](https://user-images.githubusercontent.com/14877564/183762823-d32c5a27-9d3d-41d2-9b02-a2d361cc5aa1.png)

Visual feedback can change based on the contents of the Elixir cell.

![image](https://user-images.githubusercontent.com/14877564/183762908-e11c0fcf-64c3-4877-8aa8-e93065731718.png)

Double click on the title to edit the visual feedback. You can modify the title or the code to power the visual.
Technically, this could power any post-processing on the code cell, not exclusively visuals. However this library is
primarily intended for visuals.

![image](https://user-images.githubusercontent.com/14877564/183763045-3439acf7-d9ea-4885-b149-1935395da4fc.png)
