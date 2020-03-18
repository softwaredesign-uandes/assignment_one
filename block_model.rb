class BlockModel
  attr_reader :blocks

  def initialize(blocks)
    @blocks = blocks
  end

  def reblock(rx, ry, rz)
    new_blocks = []
    nx = @blocks.length / rx
    ny = nx == 0 ? 0 : @blocks[0].length / ry
    nz = ny == 0 ? 0 : @blocks[0][0].length / rz
    for i in (0..nx - 1)
      new_blocks[i] = []
      for j in (0..ny - 1)
        new_blocks[i][j] = []
        for k in (0..nz - 1)
          new_blocks[i][j][k] = {}
        end
      end
    end

    n_i = 0
    n_j = 0
    n_k = 0
    for i in (0..@blocks.length - 1).step(rx)
      n_j = 0
      for j in (0..@blocks[0].length - 1).step(ry)
        n_k = 0
        for k in (0..@blocks[0][0].length - 1).step(rz)
          n = {}
          for ri in (i..(i + rx-1))
            for rj in (j..(j +ry-1))
              for rk in (k..(k + rz-1))
                @blocks[ri][rj][rk].each do |k__, v|
                  unless n.include? k__
                    n[k__] = 0
                  end
                  n[k__] += v
                end
              end
            end
          end

          n_2 = {}
          n.each do |k_,v|
            n_2[k_] = v / (rx * ry * rz)
          end

          new_blocks[n_i][n_j][n_k] = n_2
          n_k += 1
        end
        n_j += 1
      end
      n_i += 1
    end
    @blocks = new_blocks
  end
end