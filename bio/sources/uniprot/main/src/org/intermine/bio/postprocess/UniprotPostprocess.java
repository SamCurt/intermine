package org.intermine.bio.postprocess;

/*
 * Copyright (C) 2002-2012 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.Iterator;

import org.apache.log4j.Logger;
import org.intermine.model.bio.OntologyTerm;
import org.intermine.model.bio.Protein;
import org.intermine.objectstore.ObjectStore;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.objectstore.ObjectStoreWriter;
import org.intermine.objectstore.query.ConstraintOp;
import org.intermine.objectstore.query.ConstraintSet;
import org.intermine.objectstore.query.ContainsConstraint;
import org.intermine.objectstore.query.Query;
import org.intermine.objectstore.query.QueryClass;
import org.intermine.objectstore.query.QueryCollectionReference;
import org.intermine.objectstore.query.QueryField;
import org.intermine.objectstore.query.QueryValue;
import org.intermine.objectstore.query.Results;
import org.intermine.objectstore.query.ResultsRow;
import org.intermine.objectstore.query.SimpleConstraint;
import org.intermine.postprocess.PostProcessor;

/**
 * Take 
 *
 * @author Julie Sullivan
 */
public class UniprotPostprocess extends PostProcessor
{
    private static final Logger LOG = Logger.getLogger(UniprotPostprocess.class);
    private ObjectStore os;
    // case sensitive
    //private static final String MITOCHONDRION = "mitochrondri";
    private static final String MITOCHONDRION = "Cyto%";
     

    /**
     * Create a new UpdateOrthologes object from an ObjectStoreWriter
     * @param osw writer on genomic ObjectStore
     */
    public UniprotPostprocess(ObjectStoreWriter osw) {
        super(osw);
        this.os = osw.getObjectStore();
    }


    /**
     * Update all proteins with a mito keyword
     * @throws ObjectStoreException if anything goes wrong
     */
    @Override
    public void postProcess()
            throws ObjectStoreException {
        osw.beginTransaction();

        int count = 0;
        Iterator<?> resultsIterator = findMitoProteins(os);
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Protein thisProtein = (Protein) rr.get(0);
            thisProtein.setFieldValue("mito_evidence_UniProt_keyword", true);
            osw.store(thisProtein);
            count++;
        }
        
        LOG.info("Updated " + count + " mito proteins");
        osw.commitTransaction();
    }

    /*
     * # return all proteins with a keyword
<query name="" model="genomic" view="Protein.primaryAccession" longDescription="" sortOrder="Protein.primaryAccession asc">
 <constraint path="Protein.keywords.name" op="CONTAINS" value="mitochondrion"/>
</query>

1. update all values to be FALSE
2. run query to get all mito proteins (above)
3. update these proteins to have mito_evidence_UniProt_keyword = TRUE
     */

    private static Iterator<?> findMitoProteins(ObjectStore os)
        throws ObjectStoreException {
        Query q = new Query();
        QueryClass qcProtein = new QueryClass(Protein.class);
        QueryClass qcKeyword = new QueryClass(OntologyTerm.class);
        
        // from clause
        q.addFrom(qcProtein);
        q.addFrom(qcKeyword);
        
        // SELECT clause
        q.addToSelect(qcProtein);

        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);
        
        // Protein.keywords
        QueryCollectionReference qcr = new QueryCollectionReference(qcProtein, "keywords");
        cs.addConstraint(new ContainsConstraint(qcr, ConstraintOp.CONTAINS, qcKeyword));

        // Protein.keywords.name CONTAINS "mitochondri"
        QueryField qfKeyword = new QueryField(qcKeyword, "name");
        cs.addConstraint(new SimpleConstraint(qfKeyword, ConstraintOp.MATCHES, 
                new QueryValue(MITOCHONDRION)));
        
        // add where clause to query
        q.setConstraint(cs);
        
        // execute!
        Results res = os.execute(q);
        return res.iterator();
    }
}
