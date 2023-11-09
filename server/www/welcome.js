// var instru = `how you feel like you are a...`;
var likert = ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"];
var trials = [];

var start = {
    type: jsPsychHtmlButtonResponse,
    stimulus: '<p>Welcome to this behaviour survey, please press "start" to continue</p>',
    choices: [`Start`],
    data: { Q_num: `start` }
};

var blank = {
    type: jsPsychHtmlButtonResponse,
    stimulus: 'Press "Start" again to begin the survey',
    choices: [`Start`],
    data: { Q_num: 0 }
};

var submit_data = {
    type: jsPsychHtmlButtonResponse,
    stimulus: `that's the end of this survey, please clike 'submit' to submit your answers. Thanks for your participation.`,
    choices: ['submit'],
    data: { Q_num: `drop` }
};

export { start, blank, submit_data };
