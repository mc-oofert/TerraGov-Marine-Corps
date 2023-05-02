import { useBackend } from '../backend';
import { resolveAsset } from '../assets';
import { Button, Section, Box, Flex } from '../components';
import { Window } from '../layouts';

export const DropshipPicker = (_props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window width={510} height={500} title={'Dropship Selector'}>
      <Window.Content>
        <Flex height={'95%'} direction={'row'}>
          <Flex.Item width={'45%'}>
            <ShuttleSelection />
          </Flex.Item>
          <Flex.Item width={'55%'} height={'35%'}>
            <Box
              as="img"
              src={data.assetpath ? resolveAsset(data.assetpath) : ''}
              height={'284px'}
            />
            <Section
              title={'Description - ' + (data.name ? data.name : 'None')}
              fill>
              <Box>{data.desc !== null ? data.desc : 'Pick a ship!'}</Box>
            </Section>
          </Flex.Item>
        </Flex>
        <Button
          color={'bad'}
          width={'100%'}
          disabled={data.current_ref === null}
          onClick={() => act('confirm')}>
          {'CONFIRM SELECTION'}
        </Button>
      </Window.Content>
    </Window>
  );
};

const ShuttleSelection = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Section title="Available Models" fill>
      {data.shuttles.map((shuttle) => (
        <Box key={shuttle.ref}>
          <Button
            selected={shuttle.ref === data.current_ref}
            onClick={() => act('pickship', { ref: shuttle.ref })}>
            {shuttle.name}
          </Button>
        </Box>
      ))}
    </Section>
  );
};
