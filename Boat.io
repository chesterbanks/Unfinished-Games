rectMode(CENTER);

// Key movement
var keys = [];
keyPressed = function(){ keys[keyCode] = true; };
keyReleased = function(){ keys[keyCode] = false; };

var Boat = function(){
    this.x = 200;
    this.y = 200;
    
    this.angle = 180;
    
    this.wake = function(x, y, angle){
        this.x = x;
        this.y = y;
        this.sz = 29;
        this.angle = angle;
        
        this.trans = 50;
    };
    this.wakes = [];
    this.wake.prototype.draw = function() {
        noStroke();
        pushMatrix();
        translate(this.x, this.y);
        rotate(this.angle);
        fill(255, 255, 255, this.trans);
        ellipse(-5, 0, 30 - this.sz, 30 - this.sz);
        ellipse(5, 0, 30 - this.sz, 30 - this.sz);
        popMatrix();
        
        this.sz /= 1.1;
        
        this.trans -= 1;
    };
};
Boat.prototype.draw = function() {
    if(keyIsPressed){
        this.wakes.push(new this.wake(this.x, this.y, -this.angle));
    }
    
    for(var i in this.wakes){
        this.wakes[i].draw();
        if(this.wakes[i].trans < 0){
            this.wakes.splice(i, 1);
        }
    }
    
    noStroke();
    pushMatrix();
    translate(this.x, this.y);
    rotate(-this.angle);
    fill(235, 235, 235);
    rect(0, 0, 30, 50, 10);
    popMatrix();
    
    if(keys[RIGHT]){
        this.angle -= 2;
    }
    if(keys[LEFT]){
        this.angle += 2;
    }
    if(keys[UP]){
        this.x += sin(this.angle)*3;
        this.y += cos(this.angle)*3;
    }
    if(keys[DOWN]){
        this.x -= sin(this.angle)*3;
        this.y -= cos(this.angle)*3;
    }
};
var boat = new Boat();

var Wave = function(x, y){
    this.x = x;
    this.y = y;
    
    this.Particle = function(x, y){
        this.x = x;
        this.y = y;
        this.trans = 255;
    };
    this.Particle.prototype.draw = function() {
        noStroke();
        fill(255, 255, 255, this.trans);
        ellipse(this.x, this.y, 3, 3);
        
        this.trans /= 1.05;
    };
    this.Particles = [];
};
Wave.prototype.draw = function() {
    this.Particles.push(new this.Particle(this.x, this.y));
    
    for(var i in this.Particles){
        this.Particles[i].draw();
        if(this.Particles[i].trans < 0){
            this.Particles.splice(i, 1);
            i --;
        }
    }
    
    this.x += 3;
    this.y += sin(frameCount * 10);
};
var waves = [];

draw = function() {
    /*if(frameCount % 60 === 0){
        waves.push(new Wave(random(width), random(height)));
    }*/
    
    background(88, 169, 204);
    /*for(var i in waves){
        waves[i].draw();
    }*/
    
    noStroke();
    fill(8, 201, 255, 100);
    strokeWeight(15);
    stroke(255, 255, 255, 50);
    
    boat.draw();
};
