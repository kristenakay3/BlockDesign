function CubeTest

AssertOpenGL;

screenid=max(Screen('Screens'));

InitializeMatlabOpenGL(1);

black = BlackIndex(screenid);

[win , winRect] = Screen('OpenWindow', screenid);

escapeKey = KbName('ESCAPE');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');

Screen('TextSize', win, 80);
Screen('TextFont', win, 'Courier');
DrawFormattedText(win, 'Welcome', winRect(3)/2.7, winRect(4)/1.9, black);
Screen('Flip', win);
WaitSecs(2);
Screen('TextSize', win, 50);
DrawFormattedText(win, 'This is an example trial  \nof the block design test', winRect(3)/4.6  , winRect(4)/2.1, black);
Screen('Flip', win);
WaitSecs(6);
Screen('TextSize', win, 40);
DrawFormattedText(win, 'You will rotate the blocks at the bottom  \nof the screen to create the stimulus at \nthe top of the screen. Click on a block \nto select it and then use the arrow keys \nto rotate the block. Work as quickly as \npossible. (Press space bar to begin)', winRect(3)/7 , winRect(4)/2.5, black);
Screen('Flip', win);
KbWait;

Screen('BeginOpenGL', win);

ar=winRect(4)/winRect(3); 

glEnable(GL_DEPTH_TEST);

glEnable(GL_TEXTURE_2D);

glMatrixMode(GL_PROJECTION);
glLoadIdentity;

gluPerspective(25,1/ar,0.1,100); 

glMatrixMode(GL_MODELVIEW);
glLoadIdentity;

gluLookAt(0,0,7,0,0,0,0,1,0);

glClearColor(0,0,0,0);

val = [0 0;0 0;0 0;0 0];
whichcube = 0;
blockone = 3;
blocktwo = 3;
blockthree = 3;
blockfour = 3;
timesthrough = 0;
endtime = 0;
starttime = 0;

while (1)
    %Use mouse input to select cube
    [x,y,buttons] = GetMouse;
    if buttons(1,1) == 1
        if x < winRect(3)/2
            if y < winRect(4) - (winRect(4)/4)
                whichcube = 1;
            else
                whichcube = 3;
            end
        elseif x > winRect(3)/2
            if y < winRect(4) - (winRect(4)/4)
                whichcube = 2;
            else
                whichcube = 4;
            end
        end
    end
    
    %Change degree of rotation according to key commands
    [keyIsDown,secs, keyCode] = KbCheck;
    if keyCode(escapeKey)
        break;
    elseif keyCode(upKey)
        val(whichcube,1) = val(whichcube,1) + 1;
        if val(whichcube,1) == 360 
            val(whichcube,1) = 0;
        end
    elseif keyCode(downKey)
        val(whichcube,1) = val(whichcube,1) - 1;
        if val(whichcube,1) == -360 
            val(whichcube,1) = 0;
        end
    elseif keyCode(leftKey)
        val(whichcube,2) = val(whichcube,2) + 1;
        if val(whichcube,2) == 360 
            val(whichcube,2) = 0;
        end
    elseif keyCode(rightKey)
        val(whichcube,2) = val(whichcube,2) - 1;
        if val(whichcube,2) == -360 
            val(whichcube,2) = 0;
        end
    end
    
    %Draw Stimulus and Four Cubes using degree of rotation
    glPushMatrix;
    glScalef(.50,.50,.50);
    glTranslatef(0, 1.7, 0);
    glClear;
    stimulus();
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(-1.25, -1.5, 0); 
    glRotatef(val(1,1),1,0,0); 
    glRotatef(val(1,2),0,0,1); 
    cubeface();
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(1.25,-1.5,0);  
    glRotatef(val(2,1),1,0,0); 
    glRotatef(val(2,2),0,0,1); 
    cubeface();
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(-1.25,-4.25,0); 
    glRotatef(val(3,1),1,0,0); 
    glRotatef(val(3,2),0,0,1);
    cubeface();
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(1.25,-4.25,0);  
    glRotatef(val(4,1),1,0,0); 
    glRotatef(val(4,2),0,0,1);
    cubeface();
    glPopMatrix;
    
    %Find which side of blocks is facing forward
    for i = 1:4
        if val(i,1) < 277 && val(i,1) > 263 || val(i,1) < -263 && val(i,1) > -277 || val(i,1) < 97 && val(i,1) > 83 || val(i,1) < -83 && val(i,1) > -97
            %Check if white side of block facing forward
            if val(i,2) > -7 && val(i,2) < 7 || val(i,2) > 173 && val(i,2) < 187 || val(i,2) < -173 && val(i,2) > -187
                if i == 1
                    blockone = 1;
                elseif i == 2
                    blocktwo = 1;
                elseif i == 3
                    blockthree = 1;
                elseif i == 4
                    blockfour = 1;
                end
            end
            %Check if red side of block facing forward
            if val(i,2) > 83 && val(i,2) < 97 || val(i,2) > -97 && val(i,2) < -83 || val(i,2) < 277 && val(i,2) > 263 || val(i,2) < -263 && val(i,2) > -277
                if i == 1
                    blockone = 2;
                elseif i == 2
                    blocktwo = 2;
                elseif i == 3
                    blockthree = 2;
                elseif i == 4
                    blockfour = 2;
                end
            end
        end
        %Check if half red/white forward and check if angled correctly
        if i == 1 || i == 3
            if val(i,1) > -7 && val(i,1) < 7 || val(i,1) > 173 && val(i,1) < 187 || val(i,1) > -187 && val(i,1) < -173
                if i == 1
                    blockone = 3;
                elseif i == 3
                    blockthree = 3;
                end
            end
        elseif i == 2
            if val(i,1) > -7 && val(i,1) < 7 
                if val(i,2) < 97 && val(i,2) > 83 || val(i,2) > -277 && val(i,2) < -263
                    blocktwo = 4;
                end
            end
            if val(i,1) > 173 && val(i,1) < 187 || val(i,1) > -187 && val(i,1) < -173
                if val(i,2) > -7 && val(i,2) < 7 
                    blocktwo = 4;
                end
            end
        elseif i == 4
            if val(i,1) > -7 && val(i,1) < 7 
                if val(i,2) > 173 && val(i,2) < 187 || val(i,2) > -188 && val(i,2) < -173
                    if i == 4
                        blockfour = 4;
                    end
                end
            end
            if val(i,1) > 173 && val(i,1) < 187 || val(i,1) > -187 && val(i,1) < -173
                if val(i,2) > 263 && val(i,2) < 277 || val(i,2) > -97 && val(i,2) < -83
                    if i == 4
                        blockfour = 4;
                    end
                end
            end
        end
    end
    
    %Check if blocks are correct.  If correct break while loop.
    if blockone == 2 && blocktwo == 4 && blockthree == 2 && blockfour == 4
        break
    end
    
    Screen('EndOpenGL', win);
    [timestamp] = Screen('Flip', win);
    if timesthrough == 0
    starttime = timestamp;
    timesthrough = 1;
    end
    endtime = timestamp;
    Screen('BeginOpenGL', win);
   
end


if blockone == 2 && blocktwo == 4 && blockthree == 2 && blockfour == 4
glPushMatrix;
glScalef(.50,.50,.50);
glTranslatef(0, 1.7, 0);
glClear; 
stimulus();
glPopMatrix;

    
glPushMatrix;
glScalef(.25,.25,.25);
glTranslatef(-1, -2.02, 0); 
glRotatef(90,0,1,0);
cubeface();
glPopMatrix;
    
glPushMatrix;
glScalef(.25,.25,.25);
glTranslatef(1,-2.02,0);  
glRotatef(90,0,0,1);  
cubeface();
glPopMatrix;
    
glPushMatrix;
glScalef(.25,.25,.25);
glTranslatef(-1,-4,0); 
glRotatef(90,0,1,0);
cubeface();
glPopMatrix;
    
glPushMatrix;
glScalef(.25,.25,.25);
glTranslatef(1,-4,0);  
glRotatef(180,0,0,1); 
cubeface();
glPopMatrix;
    
Screen('EndOpenGL', win);
Screen('Flip', win);

WaitSecs(.3 ); 
 
end

assignin('base','time',endtime-starttime);
sca;

return

function stimulus()

global GL

glBegin(GL.QUADS);

glColor3f(1, 0, 0);
glVertex3f(-1,1,1);
glVertex3f(0,1,1);
glVertex3f(0,0,1);
glVertex3f(-1,0,1);

glColor3f(1, 0, 0);
glVertex3f(-1,0,1);
glVertex3f(0,0,1);
glVertex3f(0,-1,1);
glVertex3f(-1,-1,1);

glEnd;

glBegin(GL.TRIANGLES);

glColor3f(1, 0, 0);
glVertex3f(1,1,1);
glVertex3f(1,0,1);
glVertex3f(0,0,1);

glColor3f(1, 0, 0);
glVertex3f(1,0,1);
glVertex3f(1,-1,1);
glVertex3f(0,0,1);

glColor3f(1, 1, 1);     
glVertex3f(0, 1,1);
glVertex3f(1, 1,1);
glVertex3f(0, 0,1);

glColor3f(1, 1, 1);     
glVertex3f(0, -1,1);
glVertex3f(1, -1,1);
glVertex3f(0, 0,1);

glEnd;

return

function cubeface()

global GL
 
glBegin(GL.QUADS);

%Top face
glColor3f(1, 1, 1);     
glVertex3f(1, 1, -1);
glVertex3f(-1, 1, -1);
glVertex3f(-1, 1, 1);
glVertex3f(1, 1, 1);
 
%Bottom face 
glColor3f(1, 1, 1);     
glVertex3f(1, -1, 1);
glVertex3f(-1, -1, 1);
glVertex3f(-1, -1, -1);
glVertex3f(1, -1, -1);
  
%Left face 
glColor3f(1, 0, 0);     
glVertex3f(-1,  1,  1);
glVertex3f(-1,  1, -1);
glVertex3f(-1, -1, -1);
glVertex3f(-1, -1,  1);
 
%Right face 
glColor3f(1, 0, 0);     
glVertex3f(1,  1, -1);
glVertex3f(1,  1,  1); 
glVertex3f(1, -1,  1);
glVertex3f(1, -1, -1);

glEnd;

glBegin(GL.TRIANGLES);
%Front face  
glColor3f(1, 1, 1 );     
glVertex3f(1, 1, 1);
glVertex3f(-1, 1, 1);
glVertex3f(1, -1, 1);

glColor3f(1, 0, 0 );
glVertex3f(-1, 1, 1);
glVertex3f(1, -1, 1);
glVertex3f(-1, -1, 1);

%Back face  
glColor3f(1, 1, 1);     
glVertex3f(1, -1, -1);
glVertex3f(-1, -1, -1);
glVertex3f(-1,  1, -1);

glColor3f(1, 0, 0);     
glVertex3f(1, -1, -1);
glVertex3f(-1,  1, -1);
glVertex3f(1, 1, -1);

glEnd;

 return