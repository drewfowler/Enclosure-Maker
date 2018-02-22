
import os
import pyperclip

print("Enter your values in millimeters");

board_width = input("Enter the width of your board: ");
board_length = input("Enter the length of your board: ");
box_height = input("Enter the height from the bottom of the board to the tallest component (add 1 or 2 for space): ");
board_height = input("Enter the height from the lowest component on the bottom side to the bottom of the board: ");

#Start and end limits to leave room for the snap fits
end_snap_length = float(board_length)-4;
start_snap_length = 4.5;
#define percent limits for wall cutouts
earliest_percent = start_snap_length / float(board_length);
latest_percent = end_snap_length / float(board_length);




print();
print("Now we will choose what part of each side you would like removed (Looking down on the board from the top)\n");
print("The values are percentages of the wall. So the start value is the percenatge of the wall from the beginning that you want to start to cut out. The end value is the percentage that the cutout will stop.");
print("The start value of the side is from the left on the top and bottom and from the bottom on the left and right");
print("For example, if you wanted the bottom wall removed, you would give the start value a 0 (from the begining) and a 1 for the end value.\n");

print("Enter your percentages in the format 0.5 = 50%");
print("If you don't want a cutout for that wall, enter 0 for both start and end for that wall\n");

walls = input("Do you want any walls to be cut out? Enter y for YES and n for NO : ");
if walls in ['y','Y']:
    top_start = input("Enter the percentage that you want the start of the cutout to begin on the TOP wall: ");
    print();
    top_end = input("Enter the percentage that you want the wall cutout to stop on the TOP wall: ");
    print();
    bottom_start = input("Enter the percentage that you want the start of the cutout to begin on the BOTTOM wall: ");
    print();
    bottom_end = input("Enter the percentage that you want the wall cutout to stop on the BOTTOM wall: ");
    print();
    left_start = input("Enter the percentage that you want the start of the cutout to begin on the LEFT wall: ");
    print();
    left_end = input("Enter the percentage that you want the wall cutout to stop on the LEFT wall: ");
    print();
    right_start = input("Enter the percentage that you want the start of the cutout to begin on the RIGHT wall: ");
    print();
    right_end = input("Enter the percentage that you want the wall cutout to stop on the RIGHT wall: ");
    print();
    print();
else:
    top_start = 0;
    top_end = 0;
    bottom_start = 0;
    bottom_end = 0;
    left_start = 0;
    left_end = 0;
    right_start = 0;
    right_end = 0;
    print();
    
#Limit the ends and starts
if float(top_start) < earliest_percent:
    top_start = earliest_percent;
if float(top_end) > latest_percent:
    top_end = latest_percent;

if float(bottom_start) < earliest_percent:
    bottom_start = earliest_percent;
if float(bottom_end) > latest_percent:
    bottom_end = latest_percent;

if float(left_start) < earliest_percent:
    left_start = earliest_percent;
if float(left_end) > latest_percent:
    left_end = latest_percent;

if float(right_start) < earliest_percent:
    right_start = earliest_percent;
if float(right_end) > latest_percent:
    right_end = latest_percent;

    

windows = input("Do you want any windows in the lid to be cut out? Enter y for YES and n for NO : ");


print();
if windows.lower == 'y':
    print("For each side enter the percentage you want that side to be cutout towards the other side of the lid")
    top_window = input("Enter the percentage you want the TOP window cutout towards the bottom: ");
    print();
    bottom_window = input("Enter the percentage you want the BOTTOM window cutout towards the top: ");
    print();
    left_window = input("Enter the percentage you want the LEFT window cutout towards the right: ");
    print();
    right_window = input("Enter the percentage you want the RIGHT window cutout towards the left: ");
    print();
else:
    top_window = 0;
    bottom_window = 0;
    left_window = 0;
    right_window = 0;


data = "thickness = 1.5;\n" + "board_height = " + str(board_height) + "+thickness;\n" + "board_width = " + board_width + ";\n" + \
       "board_length = " + board_length + ";\n" + "box_height = " + box_height + ";\n" + "//Percentages of wall that need taken out\n//Takes percentage of the wall out due to the start and end.\n//when start = 0 and end = 1 then the whole wall is taken out.\n" \
       + "top_start = " + str(top_start) + ";\n" + "top_end = " + str(top_end) + ";\n" + "bottom_start = " + str(bottom_start) + ";\n" + "bottom_end = " + str(bottom_end) + ";\n" + "left_start = " + str(left_start) + \
       ";\n" + "left_end = " + str(left_end) + ";\n" + "right_start = " + str(right_start) + ";\n" + "right_end = " + str(right_end) + ";\n" + "//Windows\n//window value is percentage of length or width\n" \
       + "left_window = " + str(left_window) + ";\n" + "right_window = " + str(right_window) + ";\n" + "bottom_window = " + str(bottom_window) + ";\n" + "top_window = " + str(top_window) + ";\n";

pyperclip.copy(data);

##print("COPY THE TEXT BETWEEN THESE LINES\n");
##print(data)
##print();
##print("COPY THE TEXT BETWEEN THESE LINES");


os.startfile("DJ_DEV_TEMPLATE.scad");

    
    

