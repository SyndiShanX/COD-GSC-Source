/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\linked_list.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace linked_list;

function function_e0143bb4b41a77c4() {
  linkedlist = spawnStruct();
  linkedlist.startnode = undefined;
  linkedlist.endnode = undefined;
  linkedlist.nodecount = 0;
  linkedlist.var_dd1ede0842d8e484 = 1;
  return linkedlist;
}

function function_dd1ede0842d8e484(var_ab177af9e881324f) {
  return isstruct(var_ab177af9e881324f) && var_ab177af9e881324f.var_dd1ede0842d8e484 == 1;
}

function function_11a80ea7fe6ea9e0() {
  node = spawnStruct();
  node.nextnode = undefined;
  node.prevnode = undefined;
  return node;
}

function addnode(newnode, var_f3b9a2fb70be7) {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
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
    function_22573254f7088750("<dev string:x1c>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function removenode(var_7dcdc8e8873aeb30) {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
  linkedlist = self;
  isstartnode = !isDefined(var_7dcdc8e8873aeb30.prevnode);
  isendnode = !isDefined(var_7dcdc8e8873aeb30.nextnode);

  if(isstartnode && linkedlist getsize() > 1) {
    linkedlist.startnode = var_7dcdc8e8873aeb30.nextnode;
  } else if(!isstartnode) {
    var_7dcdc8e8873aeb30.prevnode.nextnode = var_7dcdc8e8873aeb30.nextnode;
  }

  if(isendnode && linkedlist getsize() > 1) {
    linkedlist.endnode = var_7dcdc8e8873aeb30.prevnode;
  } else if(!isendnode) {
    var_7dcdc8e8873aeb30.nextnode.prevnode = var_7dcdc8e8873aeb30.prevnode;
  }

  linkedlist.nodecount = max(linkedlist.nodecount - 1, 0);

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x27>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function removestartnode() {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
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
    function_22573254f7088750("<dev string:x27>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function removeendnode() {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
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
    function_22573254f7088750("<dev string:x27>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function function_7f2de7f012dc412f(var_d9e7db9b48a182d5) {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
  linkedlist = self;

  if(linkedlist.startnode == var_d9e7db9b48a182d5) {
    return;
  }

  linkedlist removenode(var_d9e7db9b48a182d5);
  linkedlist addnode(var_d9e7db9b48a182d5, 1);

  if(linkedlist function_63fe00fb459ea917()) {
    function_22573254f7088750("<dev string:x34>");
    linkedlist function_808f3bc4b7fcee6d();
  }
}

function getsize() {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
  linkedlist = self;
  return linkedlist.nodecount;
}

function getstartnode() {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
  linkedlist = self;
  return linkedlist.startnode;
}

function getendnode() {
  assertex(function_dd1ede0842d8e484(self), "This function requires that 'self' is a Linked List struct as defined in 'linked_list.gsc'");
  linkedlist = self;
  return linkedlist.endnode;
}

function function_d35c195d3d01e75e() {}

function function_c09bf9c86f65e4ac(var_ad80ec0659e85f9e) {
  var_93981ad709abb3f9 = function_e0143bb4b41a77c4();
  var_93981ad709abb3f9 function_3a28dcc9cc1b6ae3(var_ad80ec0659e85f9e);
  return var_93981ad709abb3f9;
}

function function_3a28dcc9cc1b6ae3(var_ad80ec0659e85f9e) {
  assertex(function_dd1ede0842d8e484(self), "<dev string:x58>");
  var_93981ad709abb3f9 = self;
  var_93981ad709abb3f9.var_1a19bd75a8860186 = 1;
  var_93981ad709abb3f9.var_ad80ec0659e85f9e = var_ad80ec0659e85f9e;
}

function function_c4e2f2dcd675c939(var_ad80ec0659e85f9e) {
  assertex(function_dd1ede0842d8e484(self), "<dev string:x58>");
  linkedlist = self;
  nodecount = 1;
  nodereference = linkedlist.startnode;
  function_22573254f7088750("<dev string:xb3>");
  function_22573254f7088750("<dev string:xd1>" + linkedlist getsize());

  while(isDefined(nodereference)) {
    function_22573254f7088750("<dev string:xdd>" + nodecount + "<dev string:xf0>");
    [[var_ad80ec0659e85f9e]](nodereference);
    nodereference = nodereference.nextnode;
    nodecount++;
  }

  function_22573254f7088750("<dev string:xf3>");
}

function private function_808f3bc4b7fcee6d() {
  assertex(function_dd1ede0842d8e484(self), "<dev string:x58>");
  var_93981ad709abb3f9 = self;
  function_c4e2f2dcd675c939(var_93981ad709abb3f9.var_ad80ec0659e85f9e);
}

function private function_63fe00fb459ea917() {
  assertex(function_dd1ede0842d8e484(self), "<dev string:x58>");
  linkedlist = self;
  return istrue(linkedlist.var_1a19bd75a8860186);
}

function private function_276db0f5dc47fd04() {
  return "<dev string:x10f>";
}

function private function_22573254f7088750(var_f0443bfaa4783689) {
  iprintln(function_276db0f5dc47fd04() + var_f0443bfaa4783689);
}

# /