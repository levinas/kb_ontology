module KBaseOntology {

    /*
        @optional is_anonymous name namespace alt_id def comment subset synonym xref builtin property_value is_a intersection_of union_of equivalent_to disjoint_from relationship created_by creation_date is_obsolete replaced_by consider
    */
    typedef structure {
        string id;
        string is_anonymous;
        string name;
        string namespace;
        list<string> alt_id;
        list<string> def;
        list<string> comment;
        list<string> subset;
        list<string> synonym;
        list<string> xref;
        list<string> builtin;
        list<string> property_value;
        list<string> is_a;
        list<string> intersection_of;
        list<string> union_of;
        list<string> equivalent_to;
        list<string> disjoint_from;
        list<string> relationship;
        string created_by;
        string creation_date;
        string is_obsolete;
        list<string> replaced_by;
        list<string> consider;
    } OntologyTerm;

    /*
        @optional is_anonymous name namespace alt_id def comment subset synonym xref property_value domain range builtin holds_over_chain is_anti_symmetric is_cyclic is_reflexive is_symmetric is_transitive is_functional is_inverse_functional is_a intersection_of union_of equivalent_to disjoint_from inverse_of transitive_over equivalent_to_chain disjoint_over relationship is_obsolete created_by creation_date replaced_by consider expand_assertion_to expand_expression_to is_metadata_tag is_class_level
    */
    typedef structure {
        string id;
        string is_anonymous;
        string name;
        string namespace;
        list<string> alt_id;
        list<string> def;
        list<string> comment;
        list<string> subset;
        list<string> synonym;
        list<string> xref;
        list<string> property_value;
        list<string> domain;
        list<string> range;
        list<string> builtin;
        list<string> holds_over_chain;
        string is_anti_symmetric;
        string is_cyclic;
        string is_reflexive;
        string is_symmetric;
        string is_transitive;
        string is_functional;
        string is_inverse_functional;
        list<string> is_a;
        list<string> intersection_of;
        list<string> union_of;
        list<string> equivalent_to;
        list<string> disjoint_from;
        list<string> inverse_of;
        list<string> transitive_over;
        list<string> equivalent_to_chain;
        list<string> disjoint_over;
        list<string> relationship;
        string is_obsolete;
        string created_by;
        string creation_date;
        list<string> replaced_by;
        list<string> consider;
        list<string> expand_assertion_to;
        list<string> expand_expression_to;
        string is_metadata_tag;
        string is_class_level;
    } OntologyTypedef;

    /*
        @optional is_anonymous name namespace alt_id def comment subset synonym xref instance_of property_value relationship created_by creation_date is_obsolete replaced_by consider
    */
    typedef structure {
        string id;
        string is_anonymous;
        string name;
        string namespace;
        list<string> alt_id;
        list<string> def;
        list<string> comment;
        list<string> subset;
        list<string> synonym;
        list<string> xref;
        list<string> instance_of;
        list<string> property_value;
        list<string> relationship;
        string created_by;
        string creation_date;
        string is_obsolete;
        list<string> replaced_by;
        list<string> consider;
    } OntologyInstance;

    /*
        @optional data_version date saved_by auto_generated_by import subsetdef synonymtypedef default_namespace namespace_id_rule idspace treat_xrefs_as_equivalent treat_xrefs_as_genus_differentia treat_xrefs_as_relationship treat_xrefs_as_is_a remark ontology typedef_hash instance_hash
    */
    typedef structure {
        string format_version;
        string data_version;
        string date;
        string saved_by;
        string auto_generated_by;
        list<string> import;
        list<string> subsetdef;
        list<string> synonymtypedef;
        string default_namespace;
        list<string> namespace_id_rule;
        list<string> idspace;
        list<string> treat_xrefs_as_equivalent;
        list<string> treat_xrefs_as_genus_differentia;
        list<string> treat_xrefs_as_relationship;
        list<string> treat_xrefs_as_is_a;
        list<string> remark;
        string ontology;
        mapping<string, OntologyTerm> term_hash;
        mapping<string, OntologyTypedef> typedef_hash;
        mapping<string, OntologyInstance> instance_hash;
    } OntologyDictionary;

};
