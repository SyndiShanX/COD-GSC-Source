/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dynamic_nodes.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dynamic_nodes;

node_connect_to_path() {
  if(isDefined(self.a_node_path_connections))
    self node_disconnect_from_path();

  a_connection_nodes = [];
  a_near_nodes = getanynodearray(self.origin, 240);

  if(isDefined(a_near_nodes)) {
    v_forward = anglestoforward(self.angles);

    for(nn = 0; nn < a_near_nodes.size; nn++) {
      nd_test = a_near_nodes[nn];

      if(nd_test != self) {
        v_dir = vectornormalize(nd_test.origin - self.origin);
        dot = vectordot(v_forward, v_dir);

        if(dot >= 0.3) {
          trace = bullettrace((self.origin[0], self.origin[1], self.origin[2] + 42), (nd_test.origin[0], nd_test.origin[1], nd_test.origin[2] + 42), 0, undefined, 1, 1);

          if(trace["fraction"] >= 1)
            a_connection_nodes[a_connection_nodes.size] = nd_test;
        }
      }
    }
  }

  if(a_connection_nodes.size) {
    for(i = 0; i < a_connection_nodes.size; i++)
      self node_add_connection(a_connection_nodes[i]);
  }

  return a_connection_nodes.size;
}

node_add_connection(nd_node) {
  if(!nodesarelinked(self, nd_node)) {
    if(!isDefined(self.a_node_path_connections))
      self.a_node_path_connections = [];

    linknodes(self, nd_node);
    linknodes(nd_node, self);
    self.a_node_path_connections[self.a_node_path_connections.size] = nd_node;
  }
}

node_disconnect_from_path() {
  if(isDefined(self.a_node_path_connections)) {
    for(i = 0; i < self.a_node_path_connections.size; i++) {
      nd_node = self.a_node_path_connections[i];
      unlinknodes(self, nd_node);
      unlinknodes(nd_node, self);
    }
  }

  self.a_node_path_connections = undefined;
}

entity_grab_attached_dynamic_nodes(connect_nodes_to_path) {
  if(!isDefined(connect_nodes_to_path))
    connect_nodes_to_path = 1;

  if(isDefined(self.targetname)) {
    a_nodes = getnodearray(self.targetname, "target");

    foreach(node in a_nodes) {
      if(!isDefined(self.a_dynamic_nodes))
        self.a_dynamic_nodes = [];

      if(node has_spawnflag(256))
        self.a_dynamic_nodes[self.a_dynamic_nodes.size] = node;
    }

    if(connect_nodes_to_path)
      self thread maps\_dynamic_nodes::entity_connect_dynamic_nodes_to_navigation_mesh();
  }
}

entity_connect_dynamic_nodes_to_navigation_mesh() {
  self endon("death");

  if(isDefined(self.a_dynamic_nodes)) {
    self entity_connect_nodes();
    wait 0.05;

    foreach(node in self.a_dynamic_nodes)
    dropnodetofloor(node);
  }
}

entity_connect_nodes() {
  self endon("death");

  if(!isDefined(self.a_dynamic_nodes)) {
    return;
  }
  foreach(nd_dynamic in self.a_dynamic_nodes) {
    if(!isDefined(nd_dynamic.a_linked_nodes))
      nd_dynamic.a_linked_nodes = [];

    a_near_nodes = getanynodearray(nd_dynamic.origin, 256);

    foreach(nd_test in a_near_nodes) {
      reject = 0;

      if(nd_test == nd_dynamic)
        reject = 1;

      if(isinarray(self.a_dynamic_nodes, nd_test))
        reject = 1;

      if(isinarray(nd_dynamic.a_linked_nodes, nd_test))
        reject = 1;

      if(!reject) {
        v_forward = anglestoforward(nd_dynamic.angles);
        v_dir = vectornormalize(nd_test.origin - nd_dynamic.origin);
        dot = vectordot(v_forward, v_dir);

        if(dot > 0.05)
          reject = 1;
      }

      if(!reject) {
        trace = bullettrace(nd_dynamic.origin, nd_test.origin, 0, undefined, 1, 1);

        if(trace["fraction"] < 1)
          reject = 1;
      }

      if(isDefined(nd_dynamic.type) && nd_dynamic.type == "Begin")
        reject = 1;

      if(isDefined(nd_test.type) && nd_test.type == "Begin")
        reject = 1;

      if(!reject) {
        linknodes(nd_dynamic, nd_test);
        linknodes(nd_test, nd_dynamic);
        nd_dynamic.a_linked_nodes[nd_dynamic.a_linked_nodes.size] = nd_test;
      }
    }
  }
}

entity_disconnect_dynamic_nodes_from_navigation_mesh() {
  if(isDefined(self.a_dynamic_nodes)) {
    foreach(nd_dynamic in self.a_dynamic_nodes) {
      if(isDefined(nd_dynamic.a_linked_nodes)) {
        foreach(nd_linked in nd_dynamic.a_linked_nodes) {
          unlinknodes(nd_dynamic, nd_linked);
          unlinknodes(nd_linked, nd_dynamic);
        }
      }

      nd_dynamic.a_linked_nodes = [];
    }
  }
}