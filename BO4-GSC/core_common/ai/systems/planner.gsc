/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\planner.gsc
***********************************************/

#include scripts\core_common\ai\systems\planner_blackboard;

#namespace planner;

private _blackboardsapplyundostate(planner, state) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));

  foreach(key, blackboard in planner.blackboards) {
    if(isDefined(state[key])) {
      plannerblackboard::undo(blackboard, state[key]);
      continue;
    }

    planner.blackboards[key] = undefined;
  }
}

private _blackboardscalculateundostate(planner) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));
  state = [];

  foreach(key, blackboard in planner.blackboards) {
    state[key] = plannerblackboard::getundostacksize(blackboard) - 1;
  }

  return state;
}

private _blackboardsreadmode(planner) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));

  foreach(blackboard in planner.blackboards) {
    plannerblackboard::setreadmode(blackboard);
  }
}

private _blackboardsreadwritemode(planner) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));

  foreach(blackboard in planner.blackboards) {
    plannerblackboard::setreadwritemode(blackboard);
  }
}

private _initializeplannerfunctions(functype) {
  if(!isDefined(level._plannerscriptfunctions)) {
    level._plannerscriptfunctions = [];
  }

  if(!isDefined(level._plannerscriptfunctions[functype])) {
    level._plannerscriptfunctions[functype] = [];
  }
}

private _plancalculateplanindex(planner) {
  return planner.plan.size - 1;
}

private _planexpandaction(planner, action) {
  planner.api = action.api;
  pixbeginevent(action.api);
  aiprofile_beginentry(action.api);
  assert(isstruct(planner));
  assert(isstruct(action));
  assert(action.type == "<dev string:x38>");
  assert(isarray(planner.plan));
  actionfuncs = plannerutility::getplanneractionfunctions(action.api);
  actioninfo = spawnStruct();
  actioninfo.name = action.api;

  if(isDefined(actionfuncs[#"parameterize"])) {
    _blackboardsreadwritemode(planner);
    actioninfo.params = [[actionfuncs[#"parameterize"]]](planner, action.constants);
    assert(isstruct(actioninfo.params), "<dev string:x41>" + action.api + "<dev string:x69>");
    _blackboardsreadmode(planner);
  } else {
    actioninfo.params = spawnStruct();
  }

  planner.plan[planner.plan.size] = actioninfo;
  planner.api = undefined;
  aiprofile_endentry();
  pixendevent();
  return true;
}

private _planexpandpostcondition(planner, postcondition) {
  planner.api = postcondition.api;
  pixbeginevent(postcondition.api);
  aiprofile_beginentry(postcondition.api);
  assert(isstruct(planner));
  assert(isstruct(postcondition));
  assert(postcondition.type == "<dev string:x83>");
  _blackboardsreadwritemode(planner);
  postconditionfunc = plannerutility::getplannerapifunction(postcondition.api);
  [[postconditionfunc]](planner, postcondition.constants);
  _blackboardsreadmode(planner);
  planner.api = undefined;
  aiprofile_endentry();
  pixendevent();
  return true;
}

private _planexpandprecondition(planner, precondition) {
  planner.api = precondition.api;
  pixbeginevent(precondition.api);
  aiprofile_beginentry(precondition.api);
  assert(isstruct(planner));
  assert(isstruct(precondition));
  assert(precondition.type == "<dev string:x93>");
  _blackboardsreadmode(planner);
  preconditionfunc = plannerutility::getplannerapifunction(precondition.api);
  result = [[preconditionfunc]](planner, precondition.constants);
  planner.api = undefined;
  aiprofile_endentry();
  pixendevent();
  return result;
}

private _planfindnextsibling(planner, parentnodeentry, currentchildindex) {
  assert(isstruct(planner));
  return parentnodeentry.node.children[currentchildindex + 1];
}

private _planstackhasnodes(planner) {
  assert(isstruct(planner));
  return planner.nodestack.size > 0;
}

private _planstackpeeknode(planner) {
  assert(isstruct(planner));
  assert(planner.nodestack.size > 0);
  nodeentry = planner.nodestack[planner.nodestack.size - 1];
  return nodeentry;
}

private _planstackpopnode(planner) {
  assert(isstruct(planner));
  assert(planner.nodestack.size > 0);
  nodeentry = planner.nodestack[planner.nodestack.size - 1];
  planner.nodestack[planner.nodestack.size - 1] = undefined;
  return nodeentry;
}

private _planstackpushnode(planner, node, childindex = undefined) {
  assert(isstruct(planner));
  assert(isstruct(node));
  nodeentry = spawnStruct();
  nodeentry.childindex = isDefined(childindex) ? childindex : -1;
  nodeentry.node = node;
  nodeentry.planindex = _plancalculateplanindex(planner);
  nodeentry.undostate = _blackboardscalculateundostate(planner);
  planner.nodestack[planner.nodestack.size] = nodeentry;
}

private _planpushvalidparent(planner, childnodeentry, result) {
  while(_planstackhasnodes(planner)) {
    parentnodeentry = _planstackpeeknode(planner);
    assert(isDefined(parentnodeentry));

    switch (parentnodeentry.node.type) {
      case #"sequence":
        if(result) {
          nextchildnode = _planfindnextsibling(planner, parentnodeentry, childnodeentry.childindex);

          if(isDefined(nextchildnode)) {
            _planstackpushnode(planner, nextchildnode, childnodeentry.childindex + 1);
            return 1;
          }
        } else {
          _undoplan(planner, parentnodeentry.planindex);
          _blackboardsapplyundostate(planner, parentnodeentry.undostate);
        }

        _planstackpopnode(planner);
        break;
      case #"selector":
      case #"planner":
        if(!result) {
          _undoplan(planner, parentnodeentry.planindex);
          _blackboardsapplyundostate(planner, parentnodeentry.undostate);
          nextchildnode = _planfindnextsibling(planner, parentnodeentry, childnodeentry.childindex);

          if(isDefined(nextchildnode)) {
            _planstackpushnode(planner, nextchildnode, childnodeentry.childindex + 1);
            return 1;
          }
        }

        _planstackpopnode(planner);
        break;
      default:
        _planstackpopnode(planner);
        break;
    }

    childnodeentry = parentnodeentry;
  }

  return result;
}

private _planprocessstack(planner) {
  assert(isstruct(planner));
  result = 1;
  waitedinthrottle = 0;

  while(_planstackhasnodes(planner)) {
    planner.planstarttime = getrealtime();
    nodeentry = _planstackpeeknode(planner);

    switch (nodeentry.node.type) {
      case #"action":
        result = _planexpandaction(planner, nodeentry.node);
        break;
      case #"postcondition":
        result = _planexpandpostcondition(planner, nodeentry.node);
        break;
      case #"precondition":
        result = _planexpandprecondition(planner, nodeentry.node);
        break;
      case #"selector":
      case #"sequence":
      case #"planner":
        _planstackpushnode(planner, nodeentry.node.children[0], 0);
        continue;
      default:
        assert(0, "<dev string:xa2>" + nodeentry.node.type + "<dev string:xcc>");
        break;
    }

    result = _planpushvalidparent(planner, nodeentry, result);
  }
}

private _undoplan(planner, planindex) {
  assert(isstruct(planner));
  assert(isarray(planner.plan));
  assert(planindex < planner.plan.size);

  for(index = planner.plan.size - 1; index > planindex && index >= 0; index--) {
    planner.plan[index] = undefined;
  }
}

addaction(parent, actionname, constants) {
  node = createaction(actionname, constants);
  addchild(parent, node);
  return node;
}

addchild(parent, node) {
  assert(isstruct(parent));
  assert(isstruct(node));
  assert(isarray(parent.children));
  parent.children[parent.children.size] = node;
}

addgoto(parent, gotonode) {
  addchild(parent, gotonode);
}

addselector(parent) {
  node = createselector();
  addchild(parent, node);
  return node;
}

addsequence(parent) {
  node = createsequence();
  addchild(parent, node);
  return node;
}

addpostcondition(parent, functionname, constants) {
  node = createpostcondition(functionname, constants);
  addchild(parent, node);
  return node;
}

addprecondition(parent, functionname, constants) {
  node = createprecondition(functionname, constants);
  addchild(parent, node);
  return node;
}

cancel(planner) {
  assert(isstruct(planner));
  planner.cancel = 1;
}

createaction(actionname, constants) {
  assert(!isDefined(constants) || isarray(constants));
  assert(ishash(actionname));
  node = spawnStruct();
  node.type = "action";
  node.api = actionname;
  node.constants = constants;
  return node;
}

createplanner(name) {
  assert(ishash(name));
  planner = spawnStruct();
  planner.cancel = 0;
  planner.children = [];
  planner.name = name;
  planner.planning = 0;
  planner.type = "planner";
  planner.blackboards = [];
  planner.blackboards[0] = plannerblackboard::create([]);
  return planner;
}

createpostcondition(functionname, constants) {
  assert(ishash(functionname));
  assert(!isDefined(constants) || isarray(constants));
  assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xd0>" + function_9e72a96(functionname) + "<dev string:xde>");
  node = spawnStruct();
  node.type = "postcondition";
  node.api = functionname;
  node.constants = constants;
  return node;
}

createprecondition(functionname, constants) {
  assert(ishash(functionname));
  assert(!isDefined(constants) || isarray(constants));
  assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "<dev string:xd0>" + function_9e72a96(functionname) + "<dev string:xde>");
  node = spawnStruct();
  node.type = "precondition";
  node.api = functionname;
  node.constants = constants;
  return node;
}

createselector() {
  node = spawnStruct();
  node.children = [];
  node.type = "selector";
  return node;
}

createsequence() {
  node = spawnStruct();
  node.children = [];
  node.type = "sequence";
  return node;
}

createsubblackboard(planner) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));
  newblackboardindex = planner.blackboards.size;
  defaultvalues = [];
  planner.blackboards[newblackboardindex] = plannerblackboard::create(defaultvalues);
  plannerblackboard::setreadwritemode(planner.blackboards[newblackboardindex]);
  return newblackboardindex;
}

getblackboardattribute(planner, attribute, blackboardindex = 0) {
  assert(isstruct(planner));
  assert(isstring(attribute) || ishash(attribute));
  assert(isarray(planner.blackboards));
  assert(isstruct(planner.blackboards[blackboardindex]));
  return plannerblackboard::getattribute(planner.blackboards[blackboardindex], attribute);
}

getblackboardvalues(planner, blackboardindex) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));
  assert(isstruct(planner.blackboards[blackboardindex]));
  return planner.blackboards[blackboardindex].values;
}

getsubblackboard(planner, blackboardindex) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));
  assert(blackboardindex > 0 && blackboardindex < planner.blackboards.size);
  return planner.blackboards[blackboardindex];
}

plan(planner, blackboardvalues, maxframetime = 3, starttime = undefined, var_302e19d3 = 0) {
  pixbeginevent(planner.name);
  aiprofile_beginentry(planner.name);
  assert(isstruct(planner));
  assert(isarray(blackboardvalues));
  planner.cancel = 0;
  planner.maxframetime = maxframetime;
  planner.plan = [];
  planner.planning = 1;
  planner.planstarttime = starttime;

  if(!isDefined(planner.planstarttime)) {
    planner.planstarttime = getrealtime();
  }

  if(!var_302e19d3) {
    planner.blackboards = [];
    planner.blackboards[0] = plannerblackboard::create(blackboardvalues);
  }

  planner.nodestack = [];
  _planstackpushnode(planner, planner);
  _planprocessstack(planner);
  planner.nodestack = [];
  planner.planning = 0;

  foreach(subblackboard in planner.blackboards) {
    plannerblackboard::clearundostack(subblackboard);
  }

  aiprofile_endentry();
  pixendevent();
  return planner.plan;
}

printplanner(planner, filename) {
  assert(isstruct(planner));
  file = openfile(filename, "<dev string:xfb>");
  printid = randomint(2147483647);
  _printplannernode(file, planner, 0, printid);
  _printclearprintid(planner);
  closefile(file);
}

private _printclearprintid(plannernode) {
  plannernode.printid = undefined;

  if(isDefined(plannernode.children)) {
    for(index = 0; index < plannernode.children.size; index++) {
      if(isDefined(plannernode.children[index].printid)) {
        _printclearprintid(plannernode.children[index]);
      }
    }
  }
}

private function_3af5bab0(node) {
  text = node.type;

  if(isDefined(node.name)) {
    text += "<dev string:x103>" + node.name;
  }

  if(isDefined(node.api)) {
    text += "<dev string:x103>" + node.api;
  }

  if(isDefined(node.constants)) {
    text += "<dev string:x103>";
    first = 1;

    foreach(key, value in node.constants) {
      if(!first) {
        text += "<dev string:x107>";
      }

      if(isint(value) || isfloat(value)) {
        text += key + "<dev string:x10c>" + value;
      } else if(isstring(value)) {
        text += key + "<dev string:x111>" + value + "<dev string:xcc>";
      } else if(isarray(value)) {
        text += key + "<dev string:x117>";
      } else if(!isDefined(value)) {
        text += key + "<dev string:x126>";
      }

      first = 0;
    }
  }

  if(isDefined(node.name) || isDefined(node.api)) {
    text += "<dev string:x134>";
  }

  return text;
}

private _printplannernode(file, plannernode, indent, printid) {
  assert(isstruct(plannernode));
  indentspace = "<dev string:x138>";

  for(index = 0; index < indent; index++) {
    indentspace += "<dev string:x13b>";
  }

  text = "<dev string:x138>";

  if(plannernode.printid === printid) {
    text += "<dev string:x142>";
    text += function_3af5bab0(plannernode);
    fprintln(file, indentspace + text);
    return;
  }

  plannernode.printid = printid;
  text = function_3af5bab0(plannernode);
  fprintln(file, indentspace + text);

  if(isDefined(plannernode.children)) {
    for(index = 0; index < plannernode.children.size; index++) {
      _printplannernode(file, plannernode.children[index], indent + 1, printid);
    }
  }
}

setblackboardattribute(planner, attribute, value, blackboardindex = 0, readonly = 0) {
  assert(isstruct(planner));
  assert(isstring(attribute) || ishash(attribute));
  assert(isarray(planner.blackboards));
  assert(isstruct(planner.blackboards[blackboardindex]));
  plannerblackboard::setattribute(planner.blackboards[blackboardindex], attribute, value, readonly);
}

subblackboardcount(planner) {
  assert(isstruct(planner));
  assert(isarray(planner.blackboards));
  return planner.blackboards.size - 1;
}

#namespace plannerutility;

createplannerfromasset(assetname) {
  htnasset = gethierarchicaltasknetwork(assetname);

  if(isDefined(htnasset) && htnasset.nodes.size > 0) {
    plannernodes = [];

    if(htnasset.nodes.size >= 1) {
      node = htnasset.nodes[0];
      plannernodes[0] = planner::createplanner(node.name);
    }

    for(nodeindex = 1; nodeindex < htnasset.nodes.size; nodeindex++) {
      node = htnasset.nodes[nodeindex];

      switch (node.type) {
        case #"action":
          plannernodes[nodeindex] = planner::createaction(node.name, node.constants);
          break;
        case #"postcondition":
          plannernodes[nodeindex] = planner::createpostcondition(node.name, node.constants);
          break;
        case #"precondition":
          plannernodes[nodeindex] = planner::createprecondition(node.name, node.constants);
          break;
        case #"planner":
          plannernodes[nodeindex] = planner::createplanner(node.name);
          break;
        case #"selector":
          plannernodes[nodeindex] = planner::createselector();
          break;
        case #"sequence":
          plannernodes[nodeindex] = planner::createsequence();
          break;
        case #"goto":
          plannernodes[nodeindex] = spawnStruct();
          break;
      }
    }

    for(nodeindex = 0; nodeindex < htnasset.nodes.size; nodeindex++) {
      parentnode = plannernodes[nodeindex];
      htnnode = htnasset.nodes[nodeindex];

      if(!isDefined(htnnode.childindexes) || htnnode.type == #"goto") {
        continue;
      }

      for(childindex = 0; childindex < htnnode.childindexes.size; childindex++) {
        assert(htnnode.childindexes[childindex] < plannernodes.size);
        childnum = htnnode.childindexes[childindex];
        childnode = plannernodes[childnum];

        for(htnchildnode = htnasset.nodes[childnum]; htnchildnode.type === #"goto"; htnchildnode = htnasset.nodes[childnum]) {
          assert(isDefined(htnchildnode.childindexes));
          assert(htnchildnode.childindexes.size == 1);
          childnum = htnchildnode.childindexes[0];
          childnode = plannernodes[childnum];
        }

        planner::addchild(parentnode, childnode);
      }
    }

    return plannernodes[0];
  }
}

getplannerapifunction(functionname) {
  assert(ishash(functionname) && functionname != "<dev string:x138>", "<dev string:x14c>");
  assert(isDefined(level._plannerscriptfunctions[#"api"][functionname]), "<dev string:x186>" + function_9e72a96(functionname) + "<dev string:x1a5>");
  return level._plannerscriptfunctions[#"api"][functionname];
}

getplanneractionfunctions(actionname) {
  assert(ishash(actionname) && actionname != "<dev string:x138>", "<dev string:x1bd>");
  assert(isDefined(level._plannerscriptfunctions[#"action"][actionname]), "<dev string:x1f5>" + function_9e72a96(actionname) + "<dev string:x1a5>");
  return level._plannerscriptfunctions[#"action"][actionname];
}

registerplannerapi(functionname, functionptr) {
  assert(ishash(functionname) && functionname != "<dev string:x138>", "<dev string:x212>");
  assert(isfunctionptr(functionptr), "<dev string:x251>" + function_9e72a96(functionname) + "<dev string:x280>");
  planner::_initializeplannerfunctions(#"api");
  assert(!isDefined(level._plannerscriptfunctions[#"api"][functionname]), "<dev string:x186>" + functionname + "<dev string:x2a1>");
  level._plannerscriptfunctions[#"api"][functionname] = functionptr;
}

registerplanneraction(actionname, paramfuncptr, initializefuncptr, updatefuncptr, terminatefuncptr) {
  assert(ishash(actionname) && actionname != "<dev string:x138>", "<dev string:x2b7>");
  planner::_initializeplannerfunctions("Action");
  assert(!isDefined(level._plannerscriptfunctions[#"action"][actionname]), "<dev string:x1f5>" + function_9e72a96(actionname) + "<dev string:x2a1>");
  level._plannerscriptfunctions[#"action"][actionname] = [];

  if(isfunctionptr(paramfuncptr)) {
    level._plannerscriptfunctions[#"action"][actionname][#"parameterize"] = paramfuncptr;
  }

  if(isfunctionptr(initializefuncptr)) {
    level._plannerscriptfunctions[#"action"][actionname][#"initialize"] = initializefuncptr;
  }

  if(isfunctionptr(updatefuncptr)) {
    level._plannerscriptfunctions[#"action"][actionname][#"update"] = updatefuncptr;
  }

  if(isfunctionptr(terminatefuncptr)) {
    level._plannerscriptfunctions[#"action"][actionname][#"terminate"] = terminatefuncptr;
  }
}