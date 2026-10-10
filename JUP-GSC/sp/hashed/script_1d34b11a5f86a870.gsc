/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1d34b11a5f86a870.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_f7d4abc4893d2fd2;

function function_bd44643ea1a15d08(ents, cell_size) {
  if(!isDefined(ents) || ents.size < 1) {
    return;
  }

  grid = spawnStruct();
  grid.bounds = get_bounds(ents);
  grid.cells = [];
  grid.cell_size = cell_size;
  grid.selected = [];
  x = grid.bounds.p1[0];
  y = grid.bounds.p1[1];
  colcount = 0;
  rowcount = 0;
  arr_size = ents.size;
  entcount = 0;

  while(y <= grid.bounds.p2[1]) {
    while(x <= grid.bounds.p2[0]) {
      cell = spawnStruct();
      cell.area = function_4c218d7373aabdf4(x, y, cell_size, grid.bounds);
      cell.ents = [];

      for(i = 0; i < arr_size; i++) {
        if(isDefined(ents[i]) && function_e5d4bf217be0a514(ents[i], cell.area)) {
          cell.ents[cell.ents.size] = ents[i];
          ents[i] = undefined;
          entcount++;
        }
      }

      grid.cells[grid.cells.size] = cell;
      x += cell_size;
      colcount++;
    }

    grid.cols = colcount;
    x = grid.bounds.p1[0];
    colcount = 0;
    y += cell_size;
    rowcount++;
  }

  grid.rows = rowcount;
  println("<dev string:x1c>" + "<dev string:x2c>" + entcount + "<dev string:x37>" + arr_size + "<dev string:x3c>");
  return grid;
}

function function_56570edd92b23938(grid, position, radius) {
  ents = [];
  selected = [];
  offset = position - grid.bounds.p1;
  player_r = int(floor(offset[0] / grid.cell_size));
  player_c = int(floor(offset[1] / grid.cell_size));
  player_i = player_c * grid.rows + player_r;
  cell_offset = int(floor(radius / grid.cell_size));

  for(r = player_r - cell_offset; r <= player_r + cell_offset; r++) {
    if(r < 0 || r > grid.rows - 1) {
      continue;
    }

    for(c = player_c - cell_offset; c <= player_c + cell_offset; c++) {
      if(c < 0 || c > grid.cols - 1) {
        continue;
      }

      i = c * grid.rows + r;

      foreach(ent in grid.cells[i].ents) {
        ents[ents.size] = ent;
      }

      selected[selected.size] = i;
    }
  }

  grid.selected = selected;
  return ents;
}

function private get_bounds(ents) {
  bounds = spawnStruct();
  bounds.p1 = (0, 0, 0);
  bounds.p2 = (0, 0, 0);
  x1 = 0;
  y1 = 0;
  z1 = 0;
  x2 = 0;
  y2 = 0;
  z2 = 0;

  foreach(ent in ents) {
    if(ent.origin[0] < x1) {
      x1 = ent.origin[0];
    }

    if(ent.origin[1] < y1) {
      y1 = ent.origin[1];
    }

    if(ent.origin[2] < z1) {
      z1 = ent.origin[2];
    }

    if(ent.origin[0] > x2) {
      x2 = ent.origin[0];
    }

    if(ent.origin[1] > y2) {
      y2 = ent.origin[1];
    }

    if(ent.origin[2] > z2) {
      z2 = ent.origin[2];
    }
  }

  bounds.p1 = (x1, y1, z1);
  bounds.p2 = (x2, y2, z2);
  return bounds;
}

function private function_4c218d7373aabdf4(x, y, cell_size, bounds) {
  area = spawnStruct();
  area.p1 = (x, y, 0);
  x2 = x + cell_size;
  x2 = ter_op(x2 > bounds.p2[0], bounds.p2[0], x2);
  y2 = y + cell_size;
  y2 = ter_op(y2 > bounds.p2[1], bounds.p2[1], y2);
  area.p2 = (x2, y2, 0);
  return area;
}

function private function_e5d4bf217be0a514(obj, area) {
  if(obj.origin[0] >= area.p1[0] && obj.origin[1] >= area.p1[1] && obj.origin[0] <= area.p2[0] && obj.origin[1] <= area.p2[1]) {
    return true;
  }

  return false;
}