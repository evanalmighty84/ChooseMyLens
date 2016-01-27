var recs =
{
    "primary":
    {
        "Progresive": false,
        "Design": "iD Single Vision",
        "Material": "Phoenix",
        "Treatements": [ "SHV EX3"]
    },
    "secondary":
    {
        "Progresive": false,
        "Design": "iD Single Vision",
        "Material": "Phoenix",
        "Treatements": ["SHV EX3"]
    },
    "specialty":
    {
        "Progresive": false,
        "Design": "iD Single Vision",
        "Material": "Phoenix",
        "Treatements": ["SHV EX3", "Photochromic"]
    }
};
var ageRange = 0;
var isMale = true;
function doSpecialty(answers) {
    
    recs.specialty.Design = "iD Lens Technology";
    recs.specialty.Material="Phoenix";
    recs.specialty.Progresive=true;
    addTreatment("Polarized", recs.specialty.Treatements);
    addTreatment("Photochromic", recs.specialty.Treatements);
    addTreatment("Tint", recs.specialty.Treatements);
    //remember, the default style is lifestyle
    //we pass in the style via design for special cases.
    switch (answers[14]) {
        case "Biking":
            recs.specialty.Design = "iD Single Vision";
            recs.specialty.Material="Phoenix";
            recs.specialty.Progresive=false;
            break;
        case "Boating":
            removeTreatment("Polarized", recs.specialty.Treatements);
            break;
        case "Fishing":
            break;
        case "Golfing":

            break;
        case "Hiking":
            break;
        case "Hunting":
            removeTreatment("Polarized",recs.specialty.Treatements);
            break;
        case "Running":
            recs.specialty.Design = "iD Single Vision";
            recs.specialty.Material="Phoenix";
            recs.specialty.Progresive=false;
            break;
        case "Skiing":
            recs.specialty.Design = "iD Single Vision";
            recs.specialty.Material="Phoenix";
            recs.specialty.Progresive=false;
            removeTreatment("Polarized", recs.specialty.Treatements);
            break;
        case "Tennis":
            recs.specialty.Design = "iD Single Vision";
            recs.specialty.Material = "Phoenix";
            recs.specialty.Progresive = false;
            break;
    }
}
function BuildRecs(answers) {
    ageRange = answers[1];
    isMale = answers[2];
    //crap to do if the user is under 40
    if (ageRange >= 40) {
        recs.primary.Design = "iD Lens Technology";
        recs.primary.Material="Phoenix";
        recs.primary.Progresive = true;
        recs.secondary.Design = "iD Lens Technology";
        recs.secondary.Material="Phoenix";
        recs.secondary.Progresive = true;
    }
     if(answers[4]<50)
    {
        addTreatment("Polarized",recs.primary.Treatements);
        addTreatment("Photochromic",recs.primary.Treatements);        
    }
    else
    {
        addTreatment("Polarized",recs.secondary.Treatements);
        addTreatment("Photochromic",recs.secondary.Treatements);        
    }
    if (answers[7].progressive || answers[7].bifocal) 
    {
        recs.primary.Progresive = true;
        recs.primary.Design = "iD Lens Technology";
        recs.primary.Material="Phoenix";
    }
    doSpecialty(answers);
    return recs;
};
function removeTreatment(treatment, target) {
    var itemCount = target.length;
    var temp = new Array();
    for (var i = 0; i < itemCount; i++) {
        if (target[i] != target) {
            temp.push(target[i]);
        }
    }
    target = temp;
}
    
function addTreatment(treatment, target) {
    var itemCount = target.length;
    var contains = false;
    for (var i = 0; i < itemCount; i++) {
        if (target[i] == treatment) {
            contains = true;
        }
    }
    if (!contains) {
        target.push(treatment);
    }
    return target;
}
function buildTestingAnswers() {
    //here's our testing answers
    var answers = new Array();
    //question one is age (2 == 40)
    answers[1] = 45;
    //question 2 is gender (true = male)
    answers[2] = true;
    //question 4 is inside outside
    answers[4] = 68;
    //question 5 is single pair of glasses?
    answers[5] = false;
    //question 6 is how many hours do you spend at an activity?
    answers[6] = { "computer": 8, "tv": 5, "reading": 0, "driving": 0, "sports": 0, "crafts": 0 };
    //question 7 is what glasses do you wear? all values are boolean
    answers[7] =
    {
        "single": true,
        "progressive": false,
        "bifocal": false,
        "contacts": false,
        "none": false
    };
    //question 8 is what maters to you? this is a sort order
    answers[8] =
    {
        "style": 0,
        "lensThickness": 1,
        "frameMaterial": 2,
        "fit": 3,
        "lensType": 4,
        "lensColor": 5,
        "durability": 6,
        "weight": 7
    };
    //question 9 is who the hell knows but it doesn't do anything
    answers[9] = false;
    //question 10 is who the hell knows but it doesn't do anything
    answers[10] = false;
    //question 11 is who the hell knows but it doesn't do anything
    answers[11] = false;
    //question 12 is who the hell knows but it doesn't do anything
    //historicaly this was doing some final build crap
    answers[12] = true;
    //question 14 is what sport do you play
    answers[14] = "Biking";
    return answers;
}
//alert(BuildRecs(buildTestingAnswers()));

