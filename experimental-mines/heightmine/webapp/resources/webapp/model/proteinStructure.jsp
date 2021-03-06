<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td valign="top">
      <div class="heading2">
        Current data
      </div>
    </td>
    <td valign="top">
      <div class="heading2">
        Bulk download
      </div>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="body" style="height:1%">


      <li>
      <dt>A set of 3-D structural domain predictions for <i>D. melanogaster</i>
      and <i>A. gambiae</i> proteins generated by
      <a href="http://www-cryst.bioc.cam.ac.uk/~kenji/NEW/index.htm" target="_new">Kenji Mizuguchi</a>
      is available.<br/>     </dt>

      <dt>3-D structural predictions were calculated for regions of
      the <I>D. melanogaster</I> release 3.1 peptides to which an
      <a href="http://www.ebi.ac.uk/interpro" target="_new">interpro</a> domain assignment had been
      made (only <a href="http://www.sanger.ac.uk/Software/Pfam" target="_new">PFam</a> domains
      were taken).  Structural data for each of these fragments is
      available in FlyMine. Currently the atomic coordinates for each
      structure together with a sequence-structure compatibility score
      (z-score) and a q-score are available.
    </dt>
    </li>

    <li>
    <dt>Experimentally determined protein structures for <I>D. melanogaster</I> from the <a href="http://www.rcsb.org/pdb/home/home.do" target="_new">RCSB Protein data Bank.</a>
    </dt>
    </li>
<dt> The <a href="http://www.jmol.org" target="_new">JMol structural viewer</a> has been
     integrated into FlyMine and allows viewing and further analysis of each protein
     structure.
</dt>
   </div> 	
  </td>


    <td width="40%" valign="top">
      <div class="body">
        <ul>

          <li>
            <im:querylink text="All 3-D protein structure data (Kenji Mizuguchi and PDB data) " skipBuilder="true">
  <query name="" model="genomic" view="Protein.organism.name Protein.primaryAccession Protein.name Protein.structures.identifier Protein.structures.evidence.title" sortOrder="Protein.organism.name Protein.primaryAccession Protein.name Protein.structures.identifier Protein.structures.evidence.title">
  <node path="Protein" type="Protein">
  </node>
  <node path="Protein.structures" type="ProteinStructure">
  </node>
  <node path="Protein.structures.evidence" type="DataSet">
  </node>
</query>
            </im:querylink>
          </li>

          <li>
            <im:querylink text="All 3-D protein structure data for <i>A. gambiae</i> (Kenji Mizuguchi data) " skipBuilder="true">
<query name="kenji_anopheles" model="genomic" view="Protein.primaryIdentifier Protein.primaryAccession Protein.structures.identifier Protein.structures.start Protein.structures.end Protein.structures.prosa_q_score Protein.structures.prosa_z_score Protein.structures.evidence.title" sortOrder="Protein.primaryIdentifier asc" constraintLogic="A and B">
  <node path="Protein" type="Protein">
  </node>
  <node path="Protein.structures" type="ProteinStructure">
  </node>
  <node path="Protein.structures.evidence" type="DataSet">
  </node>
  <node path="Protein.structures.evidence.title" type="String">
    <constraint op="CONTAINS" value="Kenji" description="" identifier="" code="A">
    </constraint>
  </node>
  <node path="Protein.organism" type="Organism">
    <constraint op="LOOKUP" value="Anopheles gambiae str. PEST" description="" identifier="" code="B" extraValue="">
    </constraint>
  </node>
</query>
            </im:querylink>
          </li>

          <li>
            <im:querylink text="All 3-D protein structure data for <i>D. melanogaster</i> (Kenji Mizuguchi data) " skipBuilder="true">
<query name="" model="genomic" view="Protein.primaryIdentifier Protein.primaryAccession Protein.structures.identifier Protein.structures.start Protein.structures.end Protein.structures.prosa_q_score Protein.structures.prosa_z_score Protein.structures.evidence.title" sortOrder="Protein.primaryIdentifier asc" constraintLogic="A and B">
  <node path="Protein" type="Protein">
  </node>
  <node path="Protein.structures" type="ProteinStructure">
  </node>
  <node path="Protein.structures.evidence" type="DataSet">
  </node>
  <node path="Protein.structures.evidence.title" type="String">
    <constraint op="CONTAINS" value="Kenji" description="" identifier="" code="A">
    </constraint>
  </node>
  <node path="Protein.organism" type="Organism">
    <constraint op="LOOKUP" value="Drosophila melanogaster" description="" identifier="" code="B" extraValue="">
    </constraint>
  </node>
</query>
            </im:querylink>
          </li>

          <li>
            <im:querylink text="All 3-D protein structure data for <i>D. melanogaster</i> (PDB data) " skipBuilder="true">
<query name="" model="genomic" view="Protein.primaryIdentifier Protein.name Protein.structures.identifier Protein.structures.title Protein.structures.technique Protein.structures.resolution" sortOrder="Protein.primaryIdentifier asc">
  <node path="Protein" type="Protein">
  </node>
  <node path="Protein.structures" type="ProteinStructure">
  </node>
  <node path="Protein.structures.evidence" type="DataSet">
  </node>
  <node path="Protein.structures.evidence.title" type="String">
    <constraint op="CONTAINS" value="PDB" description="" identifier="" code="A" extraValue="">
    </constraint>
  </node>
</query>
            </im:querylink>
         </li>
     </ul>
    </div>
    </td>
  </tr>
</table>
