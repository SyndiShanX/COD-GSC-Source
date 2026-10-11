/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\linked_list.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace linked_list;

function createstruct_linkedlist() {
  linkedlist = spawnStruct();
  linkedlist.startnode = undefined;
  linkedlist.endnode = undefined;
  linkedlist.nodecount = 0;
  linkedlist.islinkedlist = 1;
  return linkedlist;
}

function islinkedlist(possiblelinkedlist) {
  return isstruct(possiblelinkedlist) && possiblelinkedlist.islinkedlist == 1;
}

function function_11a80ea7fe6ea9e0() {
  node = spawnStruct();
  node.nextnode = undefined;
  node.prevnode = undefined;
  return node;
}

function addnode(newnode, var_f3b9a2fb70be7) {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;

  if(linkedlist getsize() == 0) {
    linkedlist.startnode = newnode;
    linkedlist.endnode = newnode;
  } else if(istrue(var_f3b9a2fb70be7)) {
    newnode.nextnode = linkedlist.startnode;
    linkedlist.startnode.prevnode = newnode;
    linkedlist.startnode = newnode;
  } else {
    linkedlist.endnode.nextnode = newnode;
    newnode.prevnode = linkedlist.endnode;
    linkedlist.endnode = newnode;
  }

  linkedlist.nodecount += 1;

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x7a>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function removenode(nodetoremove) {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;
  isstartnode = !isDefined(nodetoremove.prevnode);
  isendnode = !isDefined(nodetoremove.nextnode);

  if(isstartnode && linkedlist getsize() > 1) {
    linkedlist.startnode = nodetoremove.nextnode;
  } else if(!isstartnode) {
    nodetoremove.prevnode.nextnode = nodetoremove.nextnode;
  }

  if(isendnode && linkedlist getsize() > 1) {
    linkedlist.endnode = nodetoremove.prevnode;
  } else if(!isendnode) {
    nodetoremove.nextnode.prevnode = nodetoremove.prevnode;
  }

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x88>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function removestartnode() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;

  if(isDefined(linkedlist.startnode) && linkedlist getsize() > 1) {
    linkedlist.startnode = linkedlist.startnode.nextnode;
    linkedlist.startnode.prevnode = undefined;
  } else {
    linkedlist.startnode = undefined;
    linkedlist.endnode = undefined;
  }

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x88>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function removeendnode() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;

  if(isDefined(linkedlist.endnode) && linkedlist getsize() > 1) {
    linkedlist.endnode = linkedlist.endnode.prevnode;
    linkedlist.endnode.nextnode = undefined;
  } else {
    linkedlist.startnode = undefined;
    linkedlist.endnode = undefined;
  }

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x88>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function movenodetostart(nodetomove) {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;

  if(linkedlist.startnode == nodetomove) {
    return;
  }

  linkedlist removenode(nodetomove);
  linkedlist addnode(nodetomove, 1);

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x98>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function getsize() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;
  return linkedlist.nodecount;
}

function getstartnode() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;
  return linkedlist.startnode;
}

function getendnode() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;
  return linkedlist.endnode;
}

function function_d35c195d3d01e75e() {}

function function_c09bf9c86f65e4ac(var_ad80ec0659e85f9e) {
  debuglinkedlist = createstruct_linkedlist();
  debuglinkedlist function_3a28dcc9cc1b6ae3(var_ad80ec0659e85f9e);
  return debuglinkedlist;
}

function function_3a28dcc9cc1b6ae3(var_ad80ec0659e85f9e) {
  assertex(islinkedlist(self), "<dev string:x1c>");
  debuglinkedlist = self;
  debuglinkedlist.var_1a19bd75a8860186 = 1;
  debuglinkedlist.var_ad80ec0659e85f9e = var_ad80ec0659e85f9e;
}

function printlinkedlist(var_ad80ec0659e85f9e) {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;
  nodecount = 1;
  nodereference = linkedlist.startnode;
  function_22573254f7088750("<dev string:xbf>");
  function_22573254f7088750("<dev string:xe0>" + linkedlist getsize());

  while(isDefined(nodereference)) {
    function_22573254f7088750("<dev string:xef>" + nodecount + "<dev string:x105>");
    [[var_ad80ec0659e85f9e]](nodereference);
    nodereference = nodereference.nextnode;
    nodecount++;
  }

  function_22573254f7088750("<dev string:x10b>");
}

function private function_808f3bc4b7fcee6d() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  debuglinkedlist = self;
  printlinkedlist(debuglinkedlist.var_ad80ec0659e85f9e);
}

function private function_63fe00fb459ea917() {
  assertex(islinkedlist(self), "<dev string:x1c>");
  linkedlist = self;
  return istrue(linkedlist.var_1a19bd75a8860186);
}

function private function_276db0f5dc47fd04() {
  return "<dev string:x12a>";
}

function private function_22573254f7088750(var_f0443bfaa4783689) {
  iprintln(function_276db0f5dc47fd04() + var_f0443bfaa4783689);
}

# /