const getScale = async(uri) => {
    const output = await fetch (uri)
          .then (response => response.json())
    return output
}

let questionArray = await getScale('./scale.json')

for (let l; l < 4; l++) {
    console.log ('loop works');
}

console.log ('parse done');

var trials = [];
var choose = ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"];
let i;
let k = questionArray.length;

function makeJsQuestion (questionArray, choose, k) {
    for (i = 0; i < k; i++) {
        trials[i]  /*property name or key of choice*/
            = {
                type: jsPsychSurveyLikert,
                questions: [{
                    prompt: questionArray[i]['prompt'],
                    labels: choose
                }],
                data: { Q_num: `0`+ (i+1)}
            };
    }
}

makeJsQuestion (questionArray, choose, k);

export { choose, trials };
