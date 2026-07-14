/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\linked_list.gsc
******************************************/

#namespace linked_list;

function createstruct_linkedlist() {
  linkedlist = spawnStruct();
  linkedlist function_98451a23628bea54();
  return linkedlist;
}

function function_98451a23628bea54() {
  var_81f937ff3abba10d = self;
  assert(isstruct(var_81f937ff3abba10d), "<dev string:x24>");
  assert(!islinkedlist(var_81f937ff3abba10d), "<dev string:x64>");
  var_81f937ff3abba10d.startnode = undefined;
  var_81f937ff3abba10d.endnode = undefined;
  var_81f937ff3abba10d.nodecount = 0;

  level.listid = level.listid ?? 0;
  var_81f937ff3abba10d.var_e52c598eb4335372 = level.listid;
  level.listid += 1;
}

function function_4d63b53025756799() {
  assert(islinkedlist(self), "<dev string:xb3>");
  linkedlist = self;

  for(currentnode = linkedlist.startnode; isDefined(currentnode); currentnode = nextnode) {
    nextnode = currentnode.nextnode;
    currentnode.prevnode = undefined;
    currentnode.nextnode = undefined;
  }

  linkedlist.startnode = undefined;
  linkedlist.endnode = undefined;

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x111>");
    linkedlist function_5803d99eb8b6f450();
  }
}

function islinkedlist(possiblelinkedlist) {
  return isstruct(possiblelinkedlist) && isDefined(possiblelinkedlist.var_e52c598eb4335372);
}

function function_affc95f8fa292c7d() {
  node = spawnStruct();
  node.nextnode = undefined;
  node.prevnode = undefined;
  return node;
}

function addnode(newnode) {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(!isDefined(newnode.var_8ca2671d9bc23f36));
  assert(!isDefined(newnode.prev));
  assert(!isDefined(newnode.next));
  newnode.var_8ca2671d9bc23f36 = linkedlist.var_e52c598eb4335372;

  if(linkedlist.nodecount == 0) {
    linkedlist.startnode = newnode;
    linkedlist.endnode = newnode;
  } else {
    linkedlist.endnode.nextnode = newnode;
    newnode.prevnode = linkedlist.endnode;
    linkedlist.endnode = newnode;
  }

  linkedlist.nodecount += 1;

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x12a>");
    linkedlist function_5803d99eb8b6f450();
  }

  return newnode;
}

function addnodestart(newnode) {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(!isDefined(newnode.var_8ca2671d9bc23f36));
  assert(!isDefined(newnode.prev));
  assert(!isDefined(newnode.next));
  newnode.var_8ca2671d9bc23f36 = linkedlist.var_e52c598eb4335372;

  if(linkedlist.nodecount == 0) {
    linkedlist.startnode = newnode;
    linkedlist.endnode = newnode;
  } else {
    newnode.nextnode = linkedlist.startnode;
    linkedlist.startnode.prevnode = newnode;
    linkedlist.startnode = newnode;
  }

  linkedlist.nodecount += 1;

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x138>");
    linkedlist function_5803d99eb8b6f450();
  }

  return newnode;
}

function addnodeafter(newnode, afterthisnode) {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(!isDefined(newnode.var_8ca2671d9bc23f36));
  assert(!isDefined(newnode.prev));
  assert(!isDefined(newnode.next));
  assert(isDefined(afterthisnode.var_8ca2671d9bc23f36));
  assert(afterthisnode.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);
  newnode.var_8ca2671d9bc23f36 = linkedlist.var_e52c598eb4335372;

  newnode.nextnode = afterthisnode.nextnode;
  newnode.prevnode = afterthisnode;
  afterthisnode.nextnode = newnode;

  if(isDefined(newnode.nextnode)) {
    newnode.nextnode.prevnode = newnode;
  }

  linkedlist.nodecount += 1;

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x14c>");
    linkedlist function_5803d99eb8b6f450();
  }

  return newnode;
}

function addnodebefore(newnode, beforethisnode) {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(!isDefined(newnode.var_8ca2671d9bc23f36));
  assert(!isDefined(newnode.prev));
  assert(!isDefined(newnode.next));
  assert(isDefined(beforethisnode.var_8ca2671d9bc23f36));
  assert(beforethisnode.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);
  newnode.var_8ca2671d9bc23f36 = linkedlist.var_e52c598eb4335372;

  newnode.nextnode = beforethisnode;
  newnode.prevnode = beforethisnode.prevnode;

  if(isDefined(newnode.prevnode)) {
    newnode.prevnode.nextnode = newnode;
  }

  linkedlist.nodecount += 1;

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x160>");
    linkedlist function_5803d99eb8b6f450();
  }

  return newnode;
}

function removenode(nodetoremove) {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(isDefined(nodetoremove.var_8ca2671d9bc23f36));
  assert(nodetoremove.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);

  if(!isDefined(nodetoremove.prevnode)) {
    linkedlist.startnode = nodetoremove.nextnode;
  } else if(!isDefined(nodetoremove.nextnode)) {
    linkedlist.endnode = nodetoremove.prevnode;
    nodetoremove.prevnode.nextnode = undefined;
  } else {
    nodetoremove.prevnode.nextnode = nodetoremove.nextnode;
    nodetoremove.nextnode.prevnode = nodetoremove.prevnode;
  }

  nodetoremove.nextnode = undefined;
  nodetoremove.prevnode = undefined;

  nodetoremove.var_8ca2671d9bc23f36 = undefined;

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x175>");
    linkedlist function_5803d99eb8b6f450();
  }
}

function removestartnode() {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(isDefined(linkedlist.startnode.var_8ca2671d9bc23f36));
  assert(linkedlist.startnode.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);

  if(isDefined(linkedlist.startnode) && linkedlist.nodecount > 1) {
    linkedlist.startnode = linkedlist.startnode.nextnode;
    linkedlist.startnode.prevnode = undefined;
  } else {
    linkedlist.startnode = undefined;
    linkedlist.endnode = undefined;
  }

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x175>");
    linkedlist function_5803d99eb8b6f450();
  }
}

function removeendnode() {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(isDefined(linkedlist.endnode.var_8ca2671d9bc23f36));
  assert(linkedlist.endnode.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);

  if(isDefined(linkedlist.endnode) && linkedlist.nodecount > 1) {
    linkedlist.endnode = linkedlist.endnode.prevnode;
    linkedlist.endnode.nextnode = undefined;
  } else {
    linkedlist.startnode = undefined;
    linkedlist.endnode = undefined;
  }

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x175>");
    linkedlist function_5803d99eb8b6f450();
  }
}

function movenodetostart(nodetomove) {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(isDefined(nodetomove.var_8ca2671d9bc23f36));
  assert(nodetomove.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);

  if(linkedlist.startnode == nodetomove) {
    return;
  }

  linkedlist removenode(nodetomove);
  linkedlist addnodestart(nodetomove);

  if(linkedlist function_2e36719cdd13d41e()) {
    function_3cf59ca4f897acf5("<dev string:x185>");
    linkedlist function_5803d99eb8b6f450();
  }
}

function getsize() {
  linkedlist = self;
  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  return linkedlist.nodecount;
}

function getstartnode() {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(isDefined(linkedlist.startnode.var_8ca2671d9bc23f36));
  assert(linkedlist.startnode.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);

  return linkedlist.startnode;
}

function getendnode() {
  linkedlist = self;

  assert(islinkedlist(linkedlist), "<dev string:xb3>");
  assert(isDefined(linkedlist.endnode.var_8ca2671d9bc23f36));
  assert(linkedlist.endnode.var_8ca2671d9bc23f36 == linkedlist.var_e52c598eb4335372);

  return linkedlist.endnode;
}

function function_f02d986025c0668f() {}

function function_bf1d4fa998dda96d(var_ebc4d4e66e9d1867) {
  debuglinkedlist = createstruct_linkedlist();
  debuglinkedlist function_2216cbc4f0cb048e(var_ebc4d4e66e9d1867);
  return debuglinkedlist;
}

function function_2216cbc4f0cb048e(var_ebc4d4e66e9d1867) {
  assert(islinkedlist(self), "<dev string:xb3>");
  debuglinkedlist = self;
  debuglinkedlist.var_e9ae8d5dbc1130cf = 1;
  debuglinkedlist.var_ebc4d4e66e9d1867 = var_ebc4d4e66e9d1867;
}

function printlinkedlist(var_ebc4d4e66e9d1867) {
  assert(islinkedlist(self), "<dev string:xb3>");
  linkedlist = self;
  nodecount = 1;
  nodereference = linkedlist.startnode;
  function_3cf59ca4f897acf5("<dev string:x1ac>");

  function_3cf59ca4f897acf5("<dev string:x1cd>" + linkedlist.var_e52c598eb4335372);

  function_3cf59ca4f897acf5("<dev string:x1da>" + linkedlist getsize());

  while(isDefined(nodereference)) {
    function_3cf59ca4f897acf5("<dev string:x1e9>" + nodecount + "<dev string:x1ff>");
    [[var_ebc4d4e66e9d1867]](nodereference);
    nodereference = nodereference.nextnode;
    nodecount++;
  }

  function_3cf59ca4f897acf5("<dev string:x205>");
}

function private function_5803d99eb8b6f450() {
  assert(islinkedlist(self), "<dev string:xb3>");
  debuglinkedlist = self;
  printlinkedlist(debuglinkedlist.var_ebc4d4e66e9d1867);
}

function private function_2e36719cdd13d41e() {
  assert(islinkedlist(self), "<dev string:xb3>");
  linkedlist = self;
  return istrue(linkedlist.var_e9ae8d5dbc1130cf);
}

function private function_74913b7e7ce34e05() {
  return "<dev string:x224>";
}

function private function_3cf59ca4f897acf5(var_ac242bc2ecfd3790) {
  iprintln(function_74913b7e7ce34e05() + var_ac242bc2ecfd3790);
}

# /