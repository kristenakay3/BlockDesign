function CubeTest

AssertOpenGL;

screenid=max(Screen('Screens')); 

InitializeMatlabOpenGL(1);

black = BlackIndex(screenid);
white = WhiteIndex(screenid); 

[win , winRect] = Screen('OpenWindow', screenid, black,[],[],[],[],[],[],[],[0,0,1280,800]);  
 
escapeKey = KbName('ESCAPE');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');  

Screen('TextSize', win, 80);
Screen('TextFont', win, 'Courier');
DrawFormattedText(win, 'Welcome', 'center','center', white);
Screen('Flip', win);
WaitSecs(2);
Screen('TextSize', win, 50);
[~, ~, textBound] = DrawFormattedText(win, 'This is an example trial of the block design test','wrapat', 'center', white, 27);
Screen('FillRect', win,black);
DrawFormattedText(win, 'This is an example trial of the block design test','wrapat', 'center', white, 27,[],[],[],[],[(winRect(3)-(textBound(3) -textBound(1)))/2,textBound(2),((winRect(3)-(textBound(3) -textBound(1)))/2) + textBound(3),textBound(4)]  );
Screen('Flip', win);
WaitSecs(6);
Screen('TextSize', win, 40);
[~, ~, textBound] = DrawFormattedText(win, 'You will rotate the blocks at the bottom of the screen to create the stimulus at the top of the screen. Click on a block to select it and then use the arrow keys to rotate the block. Work as quickly as possible. \n\n(Press space bar to begin)','wrapat','center', white,30);
Screen('FillRect', win,black );
DrawFormattedText(win, 'You will rotate the blocks at the bottom of the screen to create the stimulus at the top of the screen. Click on a block to select it and then use the arrow keys to rotate the block. Work as quickly as possible. \n\n (Press space bar to begin)','wrapat','center', white,30,[],[],[],[],[(winRect(3)-(textBound(3) -textBound(1)))/2,textBound(2),((winRect(3)-(textBound(3) -textBound(1)))/2) + textBound(3),textBound(4)])
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
global counter
counter = 1;

while (1)
    %Use mouse input to select cube
    [x,y,buttons] = GetMouse(win);  
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
    
    %Draw Stimulus and Four Cubes using de gree of rotation
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
    glRotatef(val(2,2),0,0,1) ; 
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
        if val(i,1) < 277 && val(i,1) > 259 || val(i,1) < -263 && val(i,1) > -277 || val(i,1) < 97 && val(i,1) > 77 || val(i,1) < -83 && val(i,1) > -100
            %Check if top/bottom side of block facing forward
            if val(i,2) > -7 && val(i,2) < 7 || val(i,2) > 173 && val(i,2) < 187 || val(i,2) < -173 && val(i,2) > -187
                if i == 1
                    blockone = 1;
                elseif i == 2
                    blocktwo = 1;
               elseif i == 3
                    blockthree = 2;
                elseif i == 4
                    blockfour = 1;
                end
            end
            %Check if sides of block facing forward  
             if val(i,2) > 83 && val(i,2) < 97 || val(i,2) > -97 && val(i,2) < -83 || val(i,2) < 277 && val(i,2) > 263 || val(i,2) < -263 && val(i,2) > -277
                if i == 1
                    blockone = 2;
                elseif i == 3
                    blockthree = 3;
                elseif i == 4
                    blockfour = 2;
                end
            end
        end
        % Check if block 2 half side oriented correctly 
        if i == 2
            if val(i,1) > 263 && val(i,1) < 277 || val(i,1) < -83 && val(i,1) > -97
               if val(i,2) > -277 && val(i,2) < -263 || val(i,2) >83 && val(i,2) < 97
                   blocktwo = 4;
               end
            end
        end
        %Check if front/back forward
        if i == 1 || i == 3 || i == 2
            if val(i,1) > -7 && val(i,1) < 7 || val(i,1) > 173 && val(i,1) < 187 || val(i,1) > -187 && val(i,1) < -173
                if i == 1
                    blockone = 3;
                elseif i == 3
                    blockthree = 1;
                elseif i == 2
                    blocktwo = 2;
                end
            end
        %Check if block 4 half blocks oriented correctly 
        elseif i == 4
            if val(i,1) > -11 && val(i,1) < 7 
                if val(i,2) > 173 && val(i,2) < 187 || val(i,2) > -188 && val(i,2) < -173
                    if i == 4
                        blockfour = 4;
                    end
                end
            end
            if val(i,1) > 170 && val(i,1) < 187 || val(i,1) > -187 && val(i,1) < -170 
                if val(i,2) > 263 && val(i,2) < 277 || val(i,2) > -97 && val(i,2) < -83
                     if i == 4
                        blockfour = 4; 
                    end
                end
            end
        end
    end
    
    %Check if blocks are correct .  If correct break while loop. 
    if blockone == 2 && blocktwo == 4 && blockthree == 2 && blockfour == 4
        break
    end
    
    Screen('EndOpenGL', win);
    assignin('base','x',x); 
    assignin('base','y',y); 
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
glRotatef(90,0,1,0);  
glRotatef(-90 ,1,0,0);
cubeface();
glPopMatrix;
    
glPushMatrix ;
glScalef(.25,.25,.25);
glTranslatef(-1,-4,0); 
glRotatef(90,1,0,0);
cubeface();
glPopMatrix;
    
glPushMatrix;
glScalef(.25,.25,.25);
glTranslatef(1,-4,0);  
glRotatef(180,0,0,1); 
cubeface();
glPopMatrix;
    
Screen('EndOpenGL', win);
Screen('TextSize', win, 50);   
[~, ~, textBounds] = DrawFormattedText(win, sprintf('Time: %.2f Seconds',round(endtime-starttime,2)),'center', 'center', black);
textureRect = ones(ceil((textBounds(4) - textBounds(2)) * 1.1),...
    ceil((textBounds(3) - textBounds(1)) * 1.1)) .* black  ;
textTexture = Screen('MakeTexture', win, textureRect);
Screen('TextSize', textTexture, 50);
DrawFormattedText(textTexture,sprintf('Time: %.2f Seconds',round(endtime-starttime,2)) , 'center', 'center', white);
Screen('DrawTextures', win, textTexture, [], []);

Screen('Flip', win); 

WaitSecs(4); 
 
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
global counter 
 
glBegin(GL.TRIANGLES); 

colors = [1,1,1;1,1,1;1,1,1;1,1,1;1,0,0;1,0,0;1,0,0;1,0,0;1,1,1;1,0,0;1,1,1;1,0,0;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,0,0 ;1,1,1;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,1,1;1,0,0;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,0,0;1,0,0;1,0,0;1,0,0;1,1,1;1,0,0;1,1,1;1,0,0];

%Top face
glColor3f(colors(counter,1),colors(counter,2),colors(counter,3));     
glVertex3f(1, 1, -1);
glVertex3f(-1, 1, 1);
glVertex3f(1, 1, 1);

glColor3f(colors(counter + 1,1),colors(counter + 1,2),colors(counter + 1,3)); 
glVertex3f(-1, 1, -1);
glVertex3f(1, 1, -1);
glVertex3f(-1, 1, 1);
 
%Bottom face 
glColor3f(colors(counter + 2,1),colors(counter + 2,2),colors(counter + 2,3));     
glVertex3f(1, -1, 1);
glVertex3f(-1, -1, 1);
glVertex3f(1, -1, -1);

glColor3f(colors(counter + 3,1),colors(counter + 3,2),colors(counter + 3,3)); 
glVertex3f(-1, -1, -1);
glVertex3f(-1, -1, 1);
glVertex3f(1, -1, -1);
  
%Left face 
glColor3f(colors(counter + 4,1),colors(counter + 4,2),colors(counter + 4,3));     
glVertex3f(-1,  1,  1);
glVertex3f(-1,  1, -1);
glVertex3f(-1, -1,  1);

glColor3f(colors(counter + 5,1),colors(counter + 5,2),colors(counter + 5,3));
glVertex3f(-1,  1, -1);
glVertex3f(-1, -1, -1);
glVertex3f(-1, -1,  1);
 
%Right face 
glColor3f(colors(counter + 6,1),colors(counter + 6,2),colors(counter + 6,3));     
glVertex3f(1,  1, -1);
glVertex3f(1,  1,  1); 
glVertex3f(1, -1,  1);

glColor3f(colors(counter + 7,1),colors(counter + 7,2),colors(counter + 7,3));
glVertex3f(1,  1, -1);
glVertex3f(1, -1,  1);
glVertex3f(1, -1, -1);

%Front face  
glColor3f(colors(counter + 8,1),colors(counter + 8,2),colors(counter + 8,3));     
glVertex3f(1, 1, 1);
glVertex3f(-1, 1, 1);
glVertex3f(1, -1, 1);

glColor3f(colors(counter + 9,1),colors(counter + 9,2),colors(counter + 9,3));
glVertex3f(-1, 1, 1);
glVertex3f(1, -1, 1);
glVertex3f(-1, -1, 1);

%Back face  
glColor3f(colors(counter + 10,1),colors(counter + 10,2),colors(counter + 10,3));     
glVertex3f(1, -1, -1);
glVertex3f(-1, -1, -1);
glVertex3f(-1,  1, -1);

glColor3f(colors(counter + 11,1),colors(counter + 11,2),colors(counter + 11,3));     
glVertex3f(1, -1, -1);
glVertex3f(-1,  1, -1);
glVertex3f(1, 1, -1);

glEnd;

counter = counter + 12;
if counter == 49
     counter = 1;
end
 return