local record Client
   record RuleRule
      class: string | { string }
      instance: string | { string }
      name: string | { string }
      role: string | { string }
   end

   record RuleComponent
      properties: { string : any } -- should be every client's properties
      callback: function(any) -- should be client
      rule: RuleRule
      rule_any: RuleRule
      except: RuleRule
      except_any: RuleRule
      rule_every: RuleRule
      rule_lesser: RuleRule
      rule_greater: RuleRule
      id: any
   end

   append_rules: function({ RuleComponent })
end

return Client
