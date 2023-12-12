const getScale = async(uri) => {
    const output = await fetch (uri)
          .then (response => response.json())
    return output
}

let questionArray = await getScale('./scale.json')

console.log ('parse done');

var trials = [];
let i;
let k = questionArray.length;

function makeJsQuestion (questionArray, k) {
    for (i = 0; i < k; i++) {
        trials[i]  /*property name or key of choice*/
            = {
                type: jsPsychSurveyLikert,
                questions: [{
                    prompt: questionArray[i]['prompt'],
                    labels: questionArray[i]['choices']
                }],
                data: { Q_num: `0`+ (i+1)}
            };
        if (questionArray[i]['q_required'] == 'y') {
            trials[i].questions[0].required = true;
        } else {
            trials[i].questions[0].required = false;
        }
    }
}

makeJsQuestion (questionArray, k);

let demoArray = await getScale('./demo.json');

var demos = [];
let l;
let m = demoArray.length;

function makeJsDemo (demoArray, m) {
    for (l = 0; l < m; l++) {
        demos[l]  /*property name or key of choice*/
            = {
                questions: [{
                    prompt: demoArray[l]['prompt']
                }],
                data: { Q_num: demoArray[l]['demo_var']}
            };
        if (demoArray[l]['choices'] == null) {
            demos[l].type = jsPsychSurveyText;
        } else {
            demos[l].type = jsPsychSurveyLikert;
        };
        if (demoArray[l]['d_required'] == 'y') {
            demos[l].questions[0].required = true;
        } else {
            demos[l].questions[0].required = false;
        }
    }
}

makeJsDemo (demoArray, m);
console.log (demos);

export { trials };
