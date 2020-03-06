def tick args
	args.state.grid_target ||= args.render_target(:grid)
	defaults args.state if args.state.tick_count == 0
	input args.state, args.inputs
	update args.state
	render args.state, args.outputs, args.state.grid_target
end

def update state

end

def render state, outputs, grid_render
	outputs.static_background_color = [0,0,0]
	if state.grid[:refresh]
		10.map_with_index do |x|
			10.map_with_index do |y|
				index = state.grid[x][y]
				grid_render.static_solids << {
					x: x * state.scale,
					y: y * state.scale,
					w: state.scale,
					h: state.scale,
					r: state.colors[index].r,
					g: state.colors[index].g,
					b: state.colors[index].b
				}
			end
		end
		state.grid[:refresh] = false
	end
	outputs.sprites << {
		x: state.x + state.scale * 10,
		y: state.y + state.scale * 5,
		w: 1280,
		h: 720,
		path: :grid
	}
end

def input state, inputs

end

def defaults state
	state.x = 0
	state.y = 0
	state.scale = 40
	state.grid = {refresh: true}
	10.map_with_index do |x|
		10.map_with_index do |y|
			state.grid[x] ||= {}
			state.grid[x][y] = rand(8)
		end
	end
	state.colors = [
		{r: 255, g: 152, b: 0},
		{r: 255, g: 235, b: 59},
		{r: 139, g: 195, b: 74},
		{r: 0, g: 150, b: 136},
		{r: 3, g: 169, b: 244},
		{r: 63, g: 81, b: 181},
		{r: 156, g: 39, b: 176},
		{r: 233, g: 30, b: 99}
	]
end