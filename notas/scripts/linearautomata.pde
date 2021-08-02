const CANVASSHAPE = [400,2000];
const AUTOMATAWIDTH = 8000;
var RULE, RULELIST, IN, AUTOMATON;

var CELLSIZE = 5
const COLS = Math.ceil(AUTOMATAWIDTH/CELLSIZE);
const ROWS = Math.ceil(CANVASSHAPE[1]);


function setup() {
  let canvas = createCanvas(CANVASSHAPE[0], CANVASSHAPE[1]);
  canvas.parent('sketch-container');
  noLoop();
}

function draw() {
  background(50);
  let ruleinput = document.getElementById("ruleinput");
  let cellsize = document.getElementById("cellsize");
  RULE = parseInt(ruleinput.value);
  if (RULE>255){
    RULE = 0;
    ruleinput.value=0}

  CELLSIZE = parseInt(cellsize.value);
  RULELIST = RULE.toString(2).padStart(8, '0').split('').reverse().join('');

  AUTOMATON = [''.padStart(Math.floor(COLS/2), '0') + '1' + ''.padStart(Math.floor(COLS/2), '0')]; //Initial state
  
  for (let i = 0 ; i < ROWS; i++){
    drawCells(AUTOMATON[i], i);
    update(AUTOMATON);
  }
  console.log(AUTOMATON)

}

function drawCells (state, row){
  let colstoshow = Math.ceil(CANVASSHAPE[0]/CELLSIZE);
  for (let i=0 ; i< colstoshow ; i++){
    indice = Math.ceil(COLS/2) - Math.ceil(colstoshow/2) + i;
    if (state.charAt(indice) == '1'){
      fill(50);
    }
    else{
      fill(250);
    }
    noStroke();
    square(i*CELLSIZE,row*CELLSIZE, CELLSIZE);
  }
}

function update(A){ //Automaton update
  let oldstate = A[A.length-1]
  let newstate= '0'
  let neigh
  for (let i=1 ; i<COLS-1; i++){
    neigh = oldstate.slice(i-1, i+2);
    ruleindex = parseInt(neigh,2);
    newstate = newstate + RULELIST[ruleindex];
  }
  newstate = newstate + '0';
  A.push(newstate);
}