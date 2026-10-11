/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6a04c207a6c69f43.gsc
*************************************************/

#using scripts\sp\lights;
#namespace namespace_4ba6e399ec22a6d9;

function function_851b7e474a5af3e7() {
  if(isofflinetoolrun(64 | 2 | 4)) {
    scripts\sp\lights::init();
    println("<dev string:x1c>");
    level waittill("<dev string:x6b>");
    return;
  }

  if(isofflinetoolrun(1) && function_da210510deb3625f()) {
    println("<dev string:x77>");
    level waittill("<dev string:x6b>");
  }
}

# /