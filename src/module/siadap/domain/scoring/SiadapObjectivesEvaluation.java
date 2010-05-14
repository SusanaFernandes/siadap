package module.siadap.domain.scoring;

import myorg.util.BundleUtil;
import pt.ist.fenixWebFramework.rendererExtensions.util.IPresentableEnum;

public enum SiadapObjectivesEvaluation implements IPresentableEnum, IScoring {

    HIGH(5), MEDIUM(3), LOW(1);

    private int points;

    SiadapObjectivesEvaluation(int points) {
	this.points = points;
    }

    public int getPoints() {
	return points;
    }

    @Override
    public String getLocalizedName() {
	return BundleUtil.getStringFromResourceBundle("resources/SiadapResources", getClass().getName() + "." + name());
    }
}