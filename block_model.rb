class BlockModel
  attr_reader :blocks

  def initialize(blocks)
    @blocks = blocks
  end

  def reblock_no_fors(blocks, rx, ry, rz)
    groups = blocks.group_by { |b| [(b[:x] / rx).to_i , (b[:y] / ry).to_i , (b[:z] / rz).to_i] }
    blocks = groups.map { |indices, group_blocks| { x: indices[0], y: indices[1], z: indices[2], mass: group_blocks.sum {|b| b[:mass] } } }
  end

  def reblock(rx, ry, rz)
    nx = @blocks.length / rx
    ny = nx == 0 ? 0 : @blocks[0].length / ry
    nz = ny == 0 ? 0 : @blocks[0][0].length / rz
    
    new_blocks = initialize_empty_blocks(nx, ny, nz)

    n_i = 0
    n_j = 0
    n_k = 0
    for i in (0..@blocks.length - 1).step(rx)
      n_j = 0
      for j in (0..@blocks[0].length - 1).step(ry)
        n_k = 0
        for k in (0..@blocks[0][0].length - 1).step(rz)
          new_blocks[n_i][n_j][n_k] = reblock_neighbour_blocks(i,j,k,rx,ry,rz)
          n_k += 1
        end
        n_j += 1
      end
      n_i += 1
    end
    @blocks = new_blocks
  end

  private

  def reblock_neighbour_blocks(first_block_x_index, first_block_y_index, first_block_z_index,
    reblock_factor_x, reblock_factor_y, reblock_factor_z)
    new_block = {}
    for r_x in (first_block_x_index..(first_block_x_index + reblock_factor_x-1))
      for r_y in (first_block_y_index..(first_block_y_index +reblock_factor_y-1))
        for r_z in (first_block_z_index..(first_block_z_index + reblock_factor_z-1))
          @blocks[r_x][r_y][r_z].each do |key, value|
            unless new_block.include? key
              new_block[key] = 0
            end
            new_block[key] += value
          end
        end
      end
    end
    new_block
  end

  def initialize_empty_blocks(number_of_x_blocks, number_of_y_blocks, number_of_z_blocks)
    new_blocks = []
    for i in (0..number_of_x_blocks - 1)
      new_blocks[i] = []
      for j in (0..number_of_y_blocks - 1)
        new_blocks[i][j] = []
        for k in (0..number_of_z_blocks - 1)
          new_blocks[i][j][k] = {}
        end
      end
    end
    new_blocks
  end
end