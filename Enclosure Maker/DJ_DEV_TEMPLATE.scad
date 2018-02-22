/*//////////////////////////////////////////////////////////////////////
                Developement PCB Enclosure Script /////////////////////////////////////////////////////////////////////
/This program can be used to generate a simple enclosure to hold down a pcb via snap fits and a lid that snaps onto it
//////////////////////////////////////////////////////////////////////
/ Instructions: 1.Run the Python script.
/               2.Python will open this file.
/               3.Copy your clipboard after running the script between the two lines below.
/               4.Hit F6 and then save the .stl to your directory.
/ Author: Drew Fowler
/ Date: 2/22/2018
///////////////////////////////////////////////////////////////////////*/

/*PASTE YOUR CLIPBOARD IN BETWEEN THESE LINES */




/*PASTE YOUR CLIPBOARD IN BETWEEN THESE LINES */

/* EXAMPLE PASTED CODE
thickness = 1.5;
board_height = 4.5+thickness;
board_width = 28.8;//27.6;
board_length = 52.5;//34.5;
box_height = 19.5;


//Percentages of wall that need taken out
    //Takes percentage of the wall out due to the start and end
    //when start = 0 and end = 1 then the whole wall is taken out. 
top_start = 0;
top_end = 0;
bottom_start = 0;
bottom_end = 0;
left_start = 0;
left_end = 0;
right_start = 0;
right_end = 0;

    //Windows
    //window value is percentage of length or width
left_window = 0;
right_window = 0;
bottom_window = 0;
top_window = 0;
*/

//Don't Change these Parameters!
left_start_lid = 0;
left_end_lid = 1;
right_start_lid = 0;
right_end_lid = 1;
bottom_start_lid = 0;
bottom_end_lid = 1;
top_start_lid = 0;
top_end_lid = 1;
$fn = 50;
lid_height = 2;
smooth_r = 1.5;
board_clearance = 0.3;
lid_offset = 3;
snap_angle_b = 60;
snap_angle_t = 25;
thickness = 1.5;//1.5;
post_height = 10;
post_diameter = 1.5;
pcb_thickness = 1.6;
x = board_length+thickness*2;
y = board_width+thickness*2;

//Sets the display mode
render = "print";

if(render == "all")
{
    BASE_CUTS(bottom_start,bottom_end,right_start,right_end,left_start,left_end,top_start,top_end);
    translate([0,0,4])
    LID();
    //translate([board_clearance,board_clearance,0])
        //PCB();
    translate([board_clearance,board_clearance,0])
        POST();
    PLACE_SNAP_FIT();
}
else if(render == "base")
{
    BASE_CUTS(bottom_start,bottom_end,right_start,right_end,left_start,left_end,top_start,top_end);
    //translate([board_clearance,board_clearance,0])
        //PCB();
    translate([board_clearance,board_clearance,0])
        POST();
    PLACE_SNAP_FIT();
}
else if(render == "lid")
{
    LID();
}
else if(render == "print")
{
    BASE_CUTS();
    translate([board_length+10,0,-box_height+lid_offset])
    LID();
    translate([board_clearance,board_clearance,0])
        PCB();
    translate([board_clearance,board_clearance,0])
        POST();
    PLACE_SNAP_FIT();
}



module LID()
{
    difference()
    {
        LID_Base();
    
        //Left
         translate([-thickness,board_width*left_start_lid+thickness,board_height-2])
                cube([x*left_window,board_width*(left_end_lid - left_start_lid),box_height+10]);
        
        //Right
        translate([((x+thickness)-(x*right_window)),board_width*right_start_lid+thickness,board_height-2])
            cube([thickness+50,board_width*(right_end_lid - right_start_lid),box_height+10]);
        
        //Bottom
           translate([board_length*bottom_start_lid+thickness,-thickness,board_height-2])
            cube([board_length*(bottom_end_lid - bottom_start_lid),y*bottom_window,box_height+10]);
        
        //Top
        translate([board_length*top_start_lid+thickness,((y+thickness)-(y*top_window)),board_height-2])
            cube([board_length*(top_end_lid - top_start_lid),y,box_height+10]);
    } 
}

module LID_Base()
{
  difference(){  
    //Edge
    translate([0,0,lid_height]){
    intersection(){
        translate([-10,-10,box_height-lid_height])
        cube([x+50,y+50,lid_height]);
        BASE();
    }
    //Fill
    translate([0,0,box_height-lid_height])
        cube([x,y,lid_height]);
    //Offset
    translate([thickness,thickness,box_height-(lid_height+lid_offset)])
        cube([board_length,board_width-0.7,lid_height+lid_offset]);
    }
    
    color("red")
    rotate([0,180,0]){
        translate([-x,0,-box_height-5.5]){
          
            //bottom left
            translate([thickness+2,thickness-0.5,board_height])
                SNAP_FIT();
                
            //bottom right
            translate([board_length-2,thickness-0.5,board_height])
                SNAP_FIT();
            
            //top left
            rotate([0,0,180])
            translate([-(thickness+3),-y+thickness+0.2,board_height])
                SNAP_FIT();
            
            //top right
            rotate([0,0,180])
            translate([-(board_length-1),-y+thickness+0.2,board_height])
                SNAP_FIT();
            }
        }
    }   
}

module BASE_CUTS(bottom_start,bottom_end,right_start,right_end,left_start,left_end,top_start,top_end){

    difference(){
        BASE();
        //Left
             translate([-board_length+thickness*2,board_width*left_start+thickness,board_height-2])
            cube([thickness+50,board_width*(left_end - left_start),box_height+10]);
        //bottom
    translate([board_length*bottom_start+thickness,-board_width/2,board_height-2])
            cube([board_length*(bottom_end - bottom_start),thickness+20,box_height+10]);
        //right
        translate([x-2,board_width*right_start+thickness,board_height-2])
            cube([thickness+50,board_width*(right_end - right_start),box_height+10]);
        //TOP
           translate([board_length*top_start+thickness,board_width,board_height-2])
            cube([board_length*(top_end - top_start),thickness+20,box_height+10]);
        
    }    
    //color("red")
   
}


module BASE()
{
    //Bottom Base
    cube([x,y,thickness]);

difference(){
    hull(){    
        //left Wall
        cube([thickness,y,box_height]);
            translate([0,0,0])
            cylinder(h=box_height,r=smooth_r);
        
        //bottom Wall
        cube([x,thickness,box_height]);
            translate([x,0,0])
            cylinder(h=box_height,r=smooth_r);
        
        //Right Wall
        translate([x-thickness,0,0])
            cube([thickness,y,box_height]);
                translate([x,y,0])
                cylinder(h=box_height,r=smooth_r);
        
        //top Wall
        translate([0,y-thickness,0])
            cube([x,thickness,box_height]);
                translate([0,y,0])
                cylinder(h=box_height,r=smooth_r);
    } 
    
    translate([thickness,thickness,thickness])
        cube([board_length,board_width,box_height]);
    
}
    
}


module POST()
{
    //Top Left Through Post
    translate([thickness*4,board_width-thickness,0])
    cylinder(board_height-pcb_thickness,r=post_diameter);


    //Bottom Right Through Post
    translate([board_length-thickness*3,thickness*2,0])
    cylinder(board_height-pcb_thickness,r=post_diameter);
 
    
    //Bottom Left stand
    translate([thickness*4,thickness*2,0])
    cylinder(board_height-pcb_thickness,r=post_diameter);

    //Top Right stand
    translate([board_length-thickness*3,board_width-thickness,0])
    cylinder(board_height-pcb_thickness,r=post_diameter);
}

module PLACE_SNAP_FIT()
{
//BOTTOMS
    //bottom left
    translate([thickness+2,thickness,board_height])
        SNAP_FIT();
        
    //bottom right
    translate([board_length-2,thickness,board_height])
        SNAP_FIT();
    
    //top left
    rotate([0,0,180])
    translate([-(thickness+3),-y+thickness,board_height])
        SNAP_FIT();
    
    //top right
    rotate([0,0,180])
    translate([-(board_length-1),-y+thickness,board_height])
        SNAP_FIT();
    
//TOPS
    color("red")
rotate([0,180,0]){
    translate([-x,0,-box_height-5.5]){
      
        //bottom left
        translate([thickness+2,thickness,board_height])
            SNAP_FIT();
            
        //bottom right
        translate([board_length-2,thickness,board_height])
            SNAP_FIT();
        
        //top left
        rotate([0,0,180])
        translate([-(thickness+3),-y+thickness,board_height])
            SNAP_FIT();
        
        //top right
        rotate([0,0,180])
        translate([-(board_length-1),-y+thickness,board_height])
            SNAP_FIT();
    }
}
}


module SNAP_FIT()
{
    translate([0,0,-0.35])
    difference()
    {
        cube([1,1,4]);
        //bottom angle
        rotate(a=-snap_angle_b,v=[1,0,0])
        translate([-0.1,-0.3,0])
        cube([2,2,4]);
        
        //top angle
        rotate(a=snap_angle_t,v=[1,0,0])
        translate([-0.1,1.5,0])
        cube([2,2,4]);
    }
    
}

module PCB()
{
    color("Aqua")
    translate([0+thickness,-0+thickness,board_height])
    import("BLE Dev2.stl");
}


    
    