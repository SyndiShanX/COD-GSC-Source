/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\max_heap.gsc
***************************************/

#using scripts\engine\utility;
#namespace max_heap;

function push(ref_hash, element, priority) {
  assert(isDefined(element) && isDefined(ref_hash) && isDefined(priority));

  if(!isxhash(ref_hash)) {
    ref_hash = getxhash(ref_hash);
  }

  if(!isDefined(level.var_7f5d5f60355f3468)) {
    level.var_7f5d5f60355f3468 = [];
  }

  node = spawnStruct();
  node.element = element;
  node.priority = priority;

  if(!isDefined(level.var_7f5d5f60355f3468[ref_hash])) {
    level.var_7f5d5f60355f3468[ref_hash] = [];
  }

  level.var_7f5d5f60355f3468[ref_hash][level.var_7f5d5f60355f3468[ref_hash].size] = node;
  heapify_up(ref_hash, level.var_7f5d5f60355f3468[ref_hash].size - 1);
}

function pop(ref_hash) {
  assert(isDefined(ref_hash));

  if(is_empty(ref_hash)) {
    assertmsg("<dev string:x24>" + ref_hash + "<dev string:x4b>");
    return undefined;
  }

  top_node = level.var_7f5d5f60355f3468[ref_hash][0];
  last_node = level.var_7f5d5f60355f3468[ref_hash][level.var_7f5d5f60355f3468[ref_hash].size - 1];
  level.var_7f5d5f60355f3468[ref_hash][0] = last_node;
  utility::array_remove_index(level.var_7f5d5f60355f3468[ref_hash], level.var_7f5d5f60355f3468[ref_hash].size - 1);
  heapify_down(ref_hash, 0);
  return top_node.element;
}

function peek(ref_hash) {
  assert(isDefined(ref_hash));

  if(is_empty(ref_hash)) {
    assertmsg("<dev string:x24>" + ref_hash + "<dev string:x4b>");
    return undefined;
  }

  return level.var_7f5d5f60355f3468[ref_hash][0].element;
}

function is_empty(ref_hash) {
  assert(isDefined(ref_hash));

  if(isDefined(level.var_7f5d5f60355f3468[ref_hash])) {
    return (level.var_7f5d5f60355f3468[ref_hash].size == 0);
  }

  return true;
}

function private heapify_up(ref_hash, index) {
  assert(isDefined(ref_hash) && isDefined(index));

  if(index == 0) {
    return;
  }

  parent_index = int(index * 0.5);

  if(level.var_7f5d5f60355f3468[ref_hash][index].priority > level.var_7f5d5f60355f3468[ref_hash][parent_index].priority) {
    temp_node = level.var_7f5d5f60355f3468[ref_hash][index];
    level.var_7f5d5f60355f3468[ref_hash][index] = level.var_7f5d5f60355f3468[ref_hash][parent_index];
    level.var_7f5d5f60355f3468[ref_hash][parent_index] = temp_node;
    heapify_up(ref_hash, parent_index);
  }
}

function private heapify_down(ref_hash, index) {
  assert(isDefined(ref_hash) && isDefined(index));
  var_d2cc09123ed59b5b = 2 * index + 1;
  var_6cdd4525c8a893bc = 2 * index + 2;
  largest_index = index;

  if(var_d2cc09123ed59b5b < level.var_7f5d5f60355f3468[ref_hash].size && level.var_7f5d5f60355f3468[ref_hash][var_d2cc09123ed59b5b].priority > level.var_7f5d5f60355f3468[ref_hash][largest_index].priority) {
    largest_index = var_d2cc09123ed59b5b;
  }

  if(var_6cdd4525c8a893bc < level.var_7f5d5f60355f3468[ref_hash].size && level.var_7f5d5f60355f3468[ref_hash][var_6cdd4525c8a893bc].priority > level.var_7f5d5f60355f3468[ref_hash][largest_index].priority) {
    largest_index = var_6cdd4525c8a893bc;
  }

  if(largest_index != index) {
    temp_node = level.var_7f5d5f60355f3468[ref_hash][index];
    level.var_7f5d5f60355f3468[ref_hash][index] = level.var_7f5d5f60355f3468[ref_hash][largest_index];
    level.var_7f5d5f60355f3468[ref_hash][largest_index] = temp_node;
    heapify_down(ref_hash, largest_index);
  }
}