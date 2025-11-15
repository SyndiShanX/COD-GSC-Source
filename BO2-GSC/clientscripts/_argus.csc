/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_argus.csc
**************************************/

argustextonlyui(localclientnum, text) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 33, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem = newtextelem(localclientnum, root, 2.5, 2.5, 195.0, 28.0, text, "small", 0.5);
  elem.presentation = "teletype";
  elem.font_style = "shadowed";
  elem.rate = 3;
  return root;
}

argusimageandtextui(localclientnum, image, text) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 33, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 2.5, 2.5, 20, 20, image);
  elem2 = newtextelem(localclientnum, root, 25.0, 2.5, 200 - (25.0 + 20 + 2.5), 20, text, "small", 0.5);
  elem2.presentation = "teletype";
  elem2.font_style = "shadowed";
  elem2.rate = 3;
  return root;
}

argusimageandtext2ui(localclientnum, image, text1, text2) {
  root = newmaterialelem(localclientnum, undefined, 0, 0, 200, 50, "white");
  setcolorelem(root, 1, 1, 1, 0.1, 0);
  elem1 = newmaterialelem(localclientnum, root, 2.5, 2.5, 45, 45, image);
  elem2 = newtextelem(localclientnum, root, 50.0, 2.5, 200 - (50.0 + 2.5), 10, text1, "small", 1);
  elem2.x_alignment = "center";
  elem2.font_style = "shadowed";
  elem3 = newtextelem(localclientnum, root, 50.0, 15.0, 200 - (50.0 + 2.5), 35, text2, "small", 0.6);
  elem3.presentation = "teletype";
  elem3.font_style = "shadowed";
  elem3.rate = 3;
  return root;
}