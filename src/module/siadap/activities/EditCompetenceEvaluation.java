package module.siadap.activities;

import java.util.ArrayList;
import java.util.List;

import module.siadap.domain.Competence;
import module.siadap.domain.CompetenceEvaluation;
import module.siadap.domain.Siadap;
import module.siadap.domain.SiadapProcess;
import module.workflow.activities.ActivityInformation;
import module.workflow.activities.WorkflowActivity;
import myorg.domain.User;
import myorg.util.BundleUtil;

public class EditCompetenceEvaluation extends
	WorkflowActivity<SiadapProcess, CreateOrEditCompetenceEvaluationActivityInformation> {

    // @Override
    // public boolean isActive(SiadapProcess process, User user) {
    // Siadap siadap = process.getSiadap();
    // return !siadap.isObjectiveSpecificationIntervalFinished()
    // && siadap.getEvaluator().getPerson().getUser() == user
    // && siadap.getCompetenceEvaluations().isEmpty();
    // }

    @Override
    public boolean isActive(SiadapProcess process, User user) {
	Siadap siadap = process.getSiadap();
	return !siadap.isObjectiveSpecificationIntervalFinished() && siadap.getEvaluator().getPerson().getUser() == user
		&& siadap.hasAnyCompetencesSet() && !process.hasBeenExecuted(SubmitForObjectivesAcknowledge.class);
    }

    @Override
    protected void process(CreateOrEditCompetenceEvaluationActivityInformation activityInformation) {
	Siadap siadap = activityInformation.getSiadap();
	// TODO ist154457 make this more efficient, for now, let's just remove
	// and set them again
	List<CompetenceEvaluation> previousCompetences = siadap.getCompetenceEvaluations();
	List<Competence> competencesToAdd = activityInformation.getCompetences();
	for (CompetenceEvaluation competence : previousCompetences) {
	    if (!competencesToAdd.contains(competence.getCompetence())) {
		competence.delete();
	    } else {
		competencesToAdd.remove(competence.getCompetence());
	    }
	}
	for (Competence competence : competencesToAdd) {
	    new CompetenceEvaluation(activityInformation.getSiadap(), competence);
	}
		activityInformation.getSiadap().setEvaluatedOnlyByCompetences(activityInformation.getEvaluatedOnlyByCompetences());
    }

    @Override
    public ActivityInformation<SiadapProcess> getActivityInformation(SiadapProcess process) {
	return new CreateOrEditCompetenceEvaluationActivityInformation(process, this);
    }
    
    @Override
    protected boolean shouldLogActivity(CreateOrEditCompetenceEvaluationActivityInformation activityInformation) {
    	if (activityInformation.getProcess().getSiadap().getObjectivesAndCompetencesSealedDate() != null)
    		return true;
    	else return false;
    }

    @Override
    public boolean isVisible() {
	return false;
    };

    @Override
    public boolean isDefaultInputInterfaceUsed() {
	return false;
    }

    @Override
    public String getUsedBundle() {
	return "resources/SiadapResources";
    }
}