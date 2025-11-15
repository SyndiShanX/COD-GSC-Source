/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_dev.gsc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#namespace bonuszm_dev;

function function_6f199738() {
  execdevgui("");
  level thread function_17186302();
  level thread function_10489e30();
}

function function_17186302() {
  setdvar("", 0);
  while(true) {
    if(isDefined(level.var_a9e78bf7) && getdvarstring("") == "") {
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln((((((("" + "") + "") + level.var_b1955bd6) + "") + level.var_d0e37460) + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
      printtoprightln(("" + "") + level.var_a9e78bf7[""]);
    }
    wait(0.05);
  }
}

function function_10489e30() {
  setdvar("", 0);
  while(true) {
    if(getdvarstring("") == "" || (isDefined(level.var_5deb2d16) && level.var_5deb2d16)) {
      skiptos = getskiptos();
      if(!isDefined(level.var_c7b985ff)) {
        level.var_c7b985ff = newhudelem();
        level.var_c7b985ff.alignx = "";
        level.var_c7b985ff.aligny = "";
        level.var_c7b985ff.x = 200;
        level.var_c7b985ff.y = 100;
        level.var_c7b985ff.fontscale = 2;
        level.var_c7b985ff.sort = 20;
        level.var_c7b985ff.alpha = 1;
        level.var_c7b985ff.color = vectorscale((1, 1, 1), 0.8);
        level.var_c7b985ff.font = "";
      }
      prefix = "";
      if(isDefined(level.var_5deb2d16) && level.var_5deb2d16) {
        prefix = "";
      }
      if(isDefined(level.current_skipto)) {
        level.var_c7b985ff settext((prefix + "") + level.current_skipto);
      } else {
        level.var_c7b985ff settext((prefix + "") + "");
      }
    } else if(isDefined(level.var_c7b985ff)) {
      level.var_c7b985ff destroy();
    }
    wait(0.05);
  }
}

function function_a2a8d5a6() {
  setdvar("", 0);
  nodes = getallnodes();
  while(true) {
    if(getdvarstring("") == "") {
      level.var_915cfc91 = [];
      foreach(node in nodes) {
        if(node.type == "" || node.type == "") {
          if(isDefined(node.script_noteworthy) && node.script_noteworthy == "") {
            if(!isinarray(level.var_915cfc91, node.animscript)) {
              level.var_915cfc91[level.var_915cfc91.size] = node.animscript;
            }
          }
        }
      }
      foreach(animscript in level.var_915cfc91) {
        println("" + animscript);
      }
    }
    setdvar("", 0);
    wait(0.1);
  }
}