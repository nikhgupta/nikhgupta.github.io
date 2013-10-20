---
layout: post
title: Validations in CakePHP
description: "My take on testing validations in CakePHP"
limelight: "Another one of my silly-write-while-learning posts. Do NOT follow
this post as the method is not recommended at all. I only wanted to jot down
my ideas somewhere!"
category: code
tags: [cakephp, php, tips, tutorials]
published: false
kind: article
created_at: 2011-08-07 12:46:31 +05:30
---

### Please, do not use follow the steps from this post!
### The post lays down some very stupid thoughts of my mind :)

Often times, I need to test my model validations in CakePHP. Although, testing
validations in CakePHP is the most easiest thing to do. I, however, prefer to
follow FactoryGirl format of testing rails code, i.e. create a base record for
the model and simply vary the only fields which need to be tested for
validation, and rest fields will be taken from the base record.

<!-- more --> 

For example, lets say we have the following database table definition:

``` sql
CREATE TABLE IF NOT EXISTS `campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id of campaign',
  `slug` text NOT NULL COMMENT 'slug-id of campaign',
  `name` text NOT NULL COMMENT 'display name for campaign',
  `active` tinyint(1) NOT NULL COMMENT 'is this campaign active?',
  `created` datetime NOT NULL COMMENT 'timestamp for creation of this campaign',
  `modified` datetime NOT NULL COMMENT 'timestamp for modification of this campaign',
  PRIMARY KEY (`id`)
);
```

Now, lets say we have a base record defined below:

``` php
<?php
$campaign = array(
  'slug' => 'test-campaign', 'name' => 'Test Campaign',
  'active' => 1, 'created' => '2011-08-01 05:57:18',
  'modified' => '2011-08-02 05:57:18'
);
```

So, what I am trying to say is, lets say, I want to create another test case
where I want to test my validation which says 'name' cannot be blank. To refer
to such a case, I want to simply do the following:

``` php
<?php
$newCase = array('name' => "");
```

which would really mean that our test record is as below:

``` php
<?php
$campaign = array(
  'slug' => 'test-campaign', 'name' => '', 'active' => 1,
  'created' => '2011-08-01 05:57:18',
  'modified' => '2011-08-02 05:57:18'
);
```

Ok.. So, now that I have defined what I am trying to achieve, lets get to the
code. Lets says, we have the following validations in our model: *Campaign*

``` php
<?php
var $validate = array(
  'slug' => array(
    'notEmpty' => array(
      'rule' => 'notEmpty',
      'message' => 'This field can not be left blank!'
    ),
    'isUnique' => array(
      'rule' => 'isUnique',
      'message' => 'A record with this Slug already exists!'
    ),
    'maxlength' => array(
      'rule' =>array('maxlength', '55'),
      'message' => "Slug can not be empty or exceed 55 chars",
    ),
  ),
  'name' => array(
    'notEmpty' => array(
      'rule' => 'notEmpty',
      'message' => 'This field can not be left blank!'
    ),
    'maxlength' => array(
    'rule' =>array('maxlength', '55'),
    'message' => "Name can not exceed 55 chars",
    ),
  ),
);
```

So, we first create our test cases as below:

``` php
<?php
$testCases = array(
  array(
    array(), // should be true
    array('slug' => 'some-random-slug'), // Valid Slug
    array('name' => "Some Random Name"), // Valid Name
  ),
  array(
    array(), // slug needs to be unique
    array('slug' => str_repeat('a', 56)), // slug needs to be less than 55 characters
    array('slug' => ""), // slug is required
    array('name' => str_repeat('a', 56)), // name cannot exceed 55 characters
    array('name' => ""), // name is required
  )
);
```

note that, the first array defines cases which will be validated, while the
second case tells us cases which will not be valid.

Our complete validation testing would be like the following, hence:

``` php
<?php
function testValidations() {
  $baseCase = array(
    'slug'     => 'test-campaign',
    'name'     => 'Test Campaign',
    'active'   => 1,
    'created'  => '2011-08-01 05:57:18',
    'modified' => '2011-08-02 05:57:18'
  );

  $testCases = array(
    array(
      array(), // should be true
      array('slug' => 'some-random-slug'), // Valid Slug
      array('name' => "Some Random Name"), // Valid Name
    ),
    array(
      array(), // slug needs to be unique
      array('slug' => str_repeat('a', 56)), // slug needs to be less than 55 characters
      array('slug' => ""), // slug is required
      array('name' => str_repeat('a', 56)), // name cannot exceed 55 characters
      array('name' => ""), // name is required
    )
  );

  $campaignCases = $this->__generateCasesOnGivenConditions($baseCase, $testCases, 1000);

  foreach ($campaignCases as $expected => $cases) {
    foreach ($cases as $case) {
      $result = $this->Campaign->save($case);
      // var_dump($result == $expected, $case);
      if ($expected) $this->assertTrue($result);
      else $this->assertFalse($result);
    }
  }
}

function __generateCasesOnGivenConditions($baseCase, $testCases, $offset) {
  $return = array();
  $trueConditions = $testCases[0]; $falseConditions = $testCases[1];
  foreach ($trueConditions as $index => $param) {
    if (!isset($param['id'])) $param['id'] = $index + $offset + 1;
    if (!isset($param['slug'])) $param['slug'] = $baseCase['slug'] . " - " . $index;
    $return[true][] = array_merge($baseCase, $param);
  }
  foreach ($falseConditions as $index => $param) {
    if (!isset($param['id'])) $param['id'] = $index + $offset + count($trueConditions) + 1;
    if (!isset($param['slug'])) $param['slug'] = $baseCase['slug'] . " - " . $index;
    $return[false][] = array_merge($baseCase, $param);
  }
  return $return;
}
```

Happy Testing Validations! :)
